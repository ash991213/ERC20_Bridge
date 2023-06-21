## Simple ERC20 Token Bridge Contract

- This is a simple Bridge Contract for transferring ERC20 tokens from one blockchain to another blockchain.

## SampleToken.sol

- SampleToken is a test token that follows the ERC20 standard.

## Components

### SampleToken.sol

- The SampleToken contract has functions to set the name, symbol, initial supply, and additional token issuance or burning functions for the administrator, inherited from the ERC20 contract.

### ERC20.sol

- The ERC20 contract is a token contract implemented to follow the ERC20 token standard.

### ISampleToken.sol

- The ISampleToken interface includes the function signatures implemented in the SampleToken contract.

## Notes

- The ownerMint and ownerBurn functions of SampleToken are only allowed for the administrator.

- If the total supply exceeds the maximum supply when minting tokens, an error occurs.

## Bridge.sol

- Bridge is a contract for transferring ERC20 tokens from one blockchain to another.

## Components

### Admin.sol

- Admin is a library that contains administrator-related functions used in the Bridge contract.

- It sets access permissions for the administrator in the Bridge contract and allows only the administrator to execute certain functions.

### Address.sol

- Address is a library that contains functions for handling data of the Address type.

### ISampleToken.sol

- ISampleToken is the interface defined for the functions implemented in the SampleToken contract. It defines the ABI for calling the public functions of the SampleToken contract.

## Main Features

- bridgeAbleToken mapping: Stores a list of ERC20 tokens that can be bridged.

- TokenSent / TokenReceive events: Events triggered when tokens are sent.

- bridgeSent function: Transfers a specific ERC20 token to another blockchain.

- bridgeReceive function: Receives a specific ERC20 token from another blockchain.

- addTokenAble function: Adds a bridgeable ERC20 token.

- removeTokenAble function: Removes a bridgeable ERC20 token.

## Bridge Process (Ethereum to BSC)

1. Users send the token address and 1000 tokens to the Bridge Contract on the Ethereum network to use the bridge functionality.

2. The Bridge Contract verifies the transaction and burns 1000 tokens.

3. The Bridge Contract on the Binance Smart Chain network mints 1000 tokens to the user.




