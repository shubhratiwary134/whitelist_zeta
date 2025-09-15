
# WalletWhitelist Smart Contract

**Solidity Version:** ^0.8.20  
**Blockchain Standard:** Compatible with ZetaBlockchain standards

## Overview

The `WalletWhitelist` smart contract allows an admin to manage a list of whitelisted wallet addresses. It provides functionality to add and remove addresses from the whitelist while ensuring secure access control and transparency through events.

## Features

- **Whitelist Management:**  
  - Admin can add specific wallet addresses to the whitelist.  
  - Admin can remove wallet addresses from the whitelist.  
  - Anyone can check if a wallet address is whitelisted.

- **Access Control:**  
  - Only the admin (set during contract deployment) can modify the whitelist.  
  - Admin-only access enforced via a Solidity `modifier`.

- **Security:**  
  - Prevents adding zero addresses (`0x0000000000000000000000000000000000000000`).  
  - Prevents adding an already whitelisted address.  
  - Prevents removing an address that is not whitelisted.

- **Events:**  
  - `AddressAdded(address indexed addedAddress)` – emitted when an address is added.  
  - `AddressRemoved(address indexed removedAddress)` – emitted when an address is removed.

## Contract Functions

| Function | Visibility | Description |
|----------|------------|-------------|
| `addToWhitelist(address _wallet)` | Admin only | Adds a wallet to the whitelist. Fails if the address is zero or already whitelisted. Emits `AddressAdded`. |
| `removeFromWhitelist(address _wallet)` | Admin only | Removes a wallet from the whitelist. Fails if the address is not whitelisted. Emits `AddressRemoved`. |
| `isWhitelisted(address _wallet)` | Public view | Returns `true` if the wallet is whitelisted, otherwise `false`. |

## Deployment

- The admin address is set at the time of deployment.  
- Compatible with ZetaBlockchain and any EVM-compatible network.

## Usage Example

```solidity
// Check if an address is whitelisted
bool whitelisted = walletWhitelist.isWhitelisted(0x123...);
