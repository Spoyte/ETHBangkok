# MEV Protection System

A DeFi solution that makes MEV bots' life harder through unpredictable swap fees on Scroll L2. We're using Uniswap v4's new hooks feature, Chronicle's price feeds, and Pyth Network's randomness to protect traders from sandwich attacks and other MEV extractions.

## Why this matters
MEV bots are everywhere on Ethereum, front-running and sandwiching trades to squeeze extra profit from regular users. We're making their job harder by making fees unpredictable - think of it as rolling a dice for each trade's fee, but in a verifiable way.

## Tech we're using
- **Blockchain stuff:**
  - Scroll L2 for fast, cheap transactions
  - Uniswap v4 Hooks to catch trades
  - Chronicle for real market prices
  - Pyth Network for random numbers
  
- **Frontend:**
  - React/Next.js
  - Tailwind CSS because we like things pretty
  - ethers.js to talk to the blockchain
  - Wagmi & RainbowKit for easy wallet connection

## Getting Started

```bash
# Get the code
git clone https://github.com/your-org/mev-protection

# Install stuff
yarn install

# Set up your environment
cp .env.example .env

# Compile the contracts
yarn hardhat compile
```

## Local Development

We spent some time setting up a local Scroll network for testing. Here's how:

```bash
# Fire up the local Scroll network
helm install scroll-devnet ./helm/scroll-devnet

# Check if everything's running
kubectl get pods -n scroll-devnet
```

### Heads up about local development
We hit some bumps with the block explorer - it's a bit tricky to get working locally. We're using a temporary solution while working on something better. If you're testing locally, you might want to use an alternative explorer for now.

## Testing Your Changes

```bash
# Run all tests
yarn test

# Test specific parts
yarn test test/MEVProtection.test.ts

# Deploy to your local network
yarn deploy:local
```

## Deployment

We're currently live on:
- Scroll Sepolia Testnet
- Local development network

```bash
# Deploy to Scroll's testnet
yarn deploy:scroll-testnet

# Verify the contracts
yarn verify:scroll
```

## What You Need in .env
```
SCROLL_RPC_URL=your_scroll_rpc
CHRONICLE_API_KEY=your_chronicle_key
PYTH_ENDPOINT=your_pyth_endpoint
PRIVATE_KEY=your_deployer_key
```

## Project Structure
```
contracts/
├── core/               # Main contracts
├── interfaces/         # Contract interfaces
└── libraries/          # Shared code

frontend/
├── components/         # React components
├── hooks/             # Custom hooks
└── pages/             # Next.js pages
```

## Current Status
- ✅ Main contracts are working
- ✅ Frontend is up and running
- ✅ Local Scroll network is set up
- 🚧 Working on better block explorer integration
- 🚧 Fine-tuning fee calculations
- 📋 Need more testing

## What's Next
- Making the protection even stronger
- Better randomization
- Expanding to other chains
- Adding more analytics

## License
MIT

## Get in Touch
- Discord: [Discord Link]
- Email: contact@mevprotection.xyz

Feel free to open issues or PRs - we're always looking to improve!

## Team
Drop us a line if you want to contribute or have questions!
- [Your Name] - Lead Dev
- [Name] - Smart Contracts
- [Name] - Frontend
