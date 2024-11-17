// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import {Hooks} from "v4-core/src/libraries/Hooks.sol";
import {IPoolManager} from "v4-core/src/interfaces/IPoolManager.sol";
import {MevProtect} from "../src/MevProtect.sol";
import {HookMiner} from "../test/utils/HookMiner.sol";
import {IEntropy} from "@pythnetwork/entropy-sdk-solidity/IEntropy.sol";
import {IChronicle} from "../src/interfaces/IChronicle.sol";
import {Constants} from "./base/Constants.sol";

contract DeployMevProtect is Script, Constants {
    // These addresses should be set based on the network
    address constant PYTH_ENTROPY = address(0); // Add actual address
    address constant CHRONICLE_ORACLE = address(0); // Add actual address

    function run() public {
        uint160 flags = uint160(
            Hooks.BEFORE_SWAP_FLAG | 
            Hooks.AFTER_SWAP_FLAG | 
            Hooks.BEFORE_SWAP_RETURNS_DELTA_FLAG
        );

        bytes memory constructorArgs = abi.encode(
            POOLMANAGER,
            PYTH_ENTROPY,
            CHRONICLE_ORACLE
        );

        (address hookAddress, bytes32 salt) = HookMiner.find(
            CREATE2_DEPLOYER, 
            flags,
            type(MevProtect).creationCode,
            constructorArgs
        );

        vm.broadcast();
        MevProtect hook = new MevProtect{salt: salt}(
            IPoolManager(POOLMANAGER),
            IEntropy(PYTH_ENTROPY),
            IChronicle(CHRONICLE_ORACLE)
        );
        
        require(address(hook) == hookAddress, "MevProtectScript: hook address mismatch");
    }
}