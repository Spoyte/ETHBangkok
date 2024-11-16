# Use the latest Alpine base image
FROM debian:12-slim

# Install dependencies
RUN apt update
RUN apt install --yes curl bash coreutils git

# Switch to bash shell
SHELL ["/bin/bash", "-c"]

# Download and run the Foundry installation script
RUN curl -L https://foundry.paradigm.xyz | bash

# Set the environment variables to ensure Foundry tools are in the PATH
ENV PATH="/root/.foundry/bin:${PATH}"

# Run foundryup to update Foundry
RUN foundryup -v nightly-7f0f5b4c1aa75dc4fd2eb15aca9757491d885902

# Expose the port Anvil uses (default: 8545)
EXPOSE 8545

# Set default value for CHAIN_ID if not provided
ENV CHAIN_ID=111111

# Command to run Anvil with the specified host, port, and chain ID
CMD ["bash", "-c", "anvil --host 0.0.0.0 --port 8545 --chain-id ${CHAIN_ID}"]