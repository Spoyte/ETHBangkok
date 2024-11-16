#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "🚀 Starting Scroll SDK deployment test..."

# Check prerequisites
echo "Checking prerequisites..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi

# Check Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Docker Compose is not installed. Please install Docker Compose first.${NC}"
    exit 1
fi

# Check Node.js version (>= 18)
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js is not installed. Please install Node.js >= 18.${NC}"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}Node.js version must be >= 18. Current version: $(node -v)${NC}"
    exit 1
fi

# Install Scroll SDK CLI
echo "Installing Scroll SDK CLI..."
npm install -g @scroll-tech/scroll-sdk-cli

# Clone the repository if not already in it
if [ ! -d "scroll-sdk-ETHBangkok" ]; then
    git clone https://github.com/scroll-tech/scroll-sdk-ETHBangkok.git
    cd scroll-sdk-ETHBangkok
fi

# Navigate to devnet directory
cd devnet

# Start the local devnet
echo "Starting local devnet..."
docker-compose up -d

# Wait for services to be ready
echo "Waiting for services to start up (30 seconds)..."
sleep 30

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo -e "${GREEN}✅ Devnet is running successfully!${NC}"
    echo "You can now:"
    echo "1. Access the L1 network at: http://localhost:8545"
    echo "2. Access the L2 network at: http://localhost:8546"
    echo "3. Access the Bridge UI at: http://localhost:3000"
else
    echo -e "${RED}❌ Some services failed to start. Check docker-compose logs for details.${NC}"
    docker-compose logs
    exit 1
fi

echo -e "\nTo stop the devnet, run: docker-compose down"
