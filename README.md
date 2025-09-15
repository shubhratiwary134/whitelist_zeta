
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


## Deployment

- The admin address is set at the time of deployment.  
- Compatible with ZetaBlockchain and any EVM-compatible network.

## Usage Example

```solidity
// Check if an address is whitelisted
bool whitelisted = walletWhitelist.isWhitelisted(0x123...);

// Admin adds a new wallet to the whitelist
walletWhitelist.addToWhitelist(0x123...);

// Admin removes a wallet from the whitelist
walletWhitelist.removeFromWhitelist(0x123...);
```

## Security Considerations

1) Only the admin can add/remove addresses.

2) Zero-address and duplicate address checks prevent common errors.

3) Events provide off-chain transparency for all whitelist changes.

## Tests

1) Fully tested using Hardhat with coverage for:

2) Admin-only access enforcement

3) Adding valid/invalid addresses

4) Removing existing/non-existing addresses

5) Event emission verification

## License

This project is licensed under the MIT License.
