// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract WalletWhitelist {
    mapping(address => bool) private whitelist;
    event AddressAdded(address addedBy, address addedOf);
    event AddressRemoved(address removedBy, address removedOf);
    address public admin;

    constructor(address[] memory initialAddresses) {
        admin = msg.sender;
        require(
            initialAddresses.length == 5,
            "The address array length should be exactly 5"
        );
        for (uint i = 0; i < initialAddresses.length; i++) {
            require(initialAddresses[i] != address(0), "address 0 not allowed");
            require(
                !whitelist[initialAddresses[i]],
                "Already Added address cannot be used again"
            );
            whitelist[initialAddresses[i]] = true;
            emit AddressAdded(admin, initialAddresses[i]);
        }
    }
    /* modifier to restrict admin-only function 
     this modifier will be used in the functions 
     addToWhitelist and removeFromWhitelist 
  */
    modifier onlyAdmin() {
        require(msg.sender == admin, "not admin");
        _;
    }

    /* function addToWhitelist and function removeFromWhitelist 
  to write to the whitelist  */
    function addToWhitelist(address addressToAdd) external onlyAdmin {
        require(addressToAdd != address(0), "address 0 not allowed");
        require(!whitelist[addressToAdd], "Address already whitelisted");
        whitelist[addressToAdd] = true;
        emit AddressAdded(admin, addressToAdd);
    }

    function removeFromWhitelist(address addressToRemove) external onlyAdmin {
        require(addressToRemove != address(0), "address 0 not allowed");
        require(
            whitelist[addressToRemove],
            "Address is already not whitelisted"
        );
        whitelist[addressToRemove] = false;
        emit AddressRemoved(admin, addressToRemove);
    }

    /* read only function to return
     boolean if the address is whitelisted
     or not */
    function isWhitelisted(
        address addressToCheck
    ) external view returns (bool) {
        return whitelist[addressToCheck];
    }
}
