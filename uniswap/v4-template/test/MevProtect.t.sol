// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Deployers} from "v4-core/test/utils/Deployers.sol";
import {IHooks} from "v4-core/src/interfaces/IHooks.sol";
import {Hooks} from "v4-core/src/libraries/Hooks.sol";
import {PoolSwapTest} from "v4-core/src/test/PoolSwapTest.sol";
import {IPoolManager} from "v4-core/src/interfaces/IPoolManager.sol";
import {PoolKey} from "v4-core/src/types/PoolKey.sol";
import {PoolId, PoolIdLibrary} from "v4-core/src/types/PoolId.sol";
import {MevProtect} from "../src/MevProtect.sol";
import {MockERC20} from "solmate/src/test/utils/mocks/MockERC20.sol";
import {IEntropy} from "@pythnetwork/entropy-sdk-solidity/IEntropy.sol";
import {IChronicle} from "../src/interfaces/IChronicle.sol";

contract MevProtectTest is Test, Deployers {
    using PoolIdLibrary for PoolKey;

    MevProtect public hook;
    PoolKey public key;
    PoolId public poolId;
    address public user = address(0xBEEF);
    
    // Mock contracts
    MockEntropy public mockEntropy;
    MockChronicle public mockChronicle;

    function setUp() public {
        // Deploy mock contracts
        mockEntropy = new MockEntropy();
        mockChronicle = new MockChronicle();
        
        // Initialize base test setup from Deployers
        initializeManagerRoutersAndPoolsWithLiq(IHooks(address(0)));

        // Deploy the hook with proper permissions
        uint160 permissions = uint160(
            Hooks.BEFORE_SWAP_FLAG | 
            Hooks.AFTER_SWAP_FLAG | 
            Hooks.BEFORE_SWAP_RETURNS_DELTA_FLAG
        );

        // Deploy hook using CREATE2
        (address hookAddress, bytes32 salt) = HookMiner.find(
            address(this), 
            permissions, 
            type(MevProtect).creationCode, 
            abi.encode(address(manager), address(mockEntropy), address(mockChronicle))
        );

        hook = new MevProtect{salt: salt}(
            IPoolManager(address(manager)),
            IEntropy(address(mockEntropy)),
            IChronicle(address(mockChronicle))
        );
        require(address(hook) == hookAddress, "MevProtectTest: hook address mismatch");

        // Create the pool
        key = PoolKey(currency0, currency1, 3000, 60, IHooks(address(hook)));
        poolId = key.toId();
        manager.initialize(key, SQRT_PRICE_1_1);
    }

    function testProtectionActivation() public {
        // Request protection for the pool
        vm.prank(user);
        hook.requestNewProtection(key, 1 hours);
        
        // Verify protection is active
        (,,,, bool isProtected) = hook.poolProtections(poolId);
        assertTrue(isProtected);
    }

    function testSwapWithProtection() public {
        // Setup protection
        vm.prank(user);
        hook.requestNewProtection(key, 1 hours);
        
        // Mock random number and price
        mockEntropy.setRandomNumber(123456);
        mockChronicle.setPrice(address(currency0), 1000e18);
        
        // Attempt swap
        vm.prank(user);
        bool swapSuccess = _attemptSwap(1e18, true);
        assertTrue(swapSuccess);
    }

    function testSwapRejection() public {
        // Setup protection with conditions that should lead to rejection
        vm.prank(user);
        hook.requestNewProtection(key, 1 hours);
        
        mockEntropy.setRandomNumber(999999);  // High random number
        mockChronicle.setPrice(address(currency0), 2000e18);  // Large price change
        
        vm.prank(user);
        vm.expectRevert("Swap rejected by MEV protection");
        _attemptSwap(1e18, true);
    }

    function _attemptSwap(uint256 amount, bool zeroForOne) internal returns (bool) {
        IPoolManager.SwapParams memory params = IPoolManager.SwapParams({
            zeroForOne: zeroForOne,
            amountSpecified: int256(amount),
            sqrtPriceLimitX96: zeroForOne ? MIN_PRICE_LIMIT : MAX_PRICE_LIMIT
        });

        PoolSwapTest.TestSettings memory testSettings = 
            PoolSwapTest.TestSettings({
                takeClaims: false,
                settleUsingBurn: false
            });

        swapRouter.swap(key, params, testSettings, "");
        return true;
    }
}

// Mock contracts for testing
contract MockEntropy {
    uint256 private randomNumber;
    
    function setRandomNumber(uint256 _number) external {
        randomNumber = _number;
    }
    
    function request() external returns (uint64) {
        return uint64(randomNumber);
    }
}

contract MockChronicle {
    mapping(address => uint256) private prices;
    
    function setPrice(address token, uint256 price) external {
        prices[token] = price;
    }
    
    function getPrice(address token) external view returns (uint256) {
        return prices[token];
    }
}