// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract WalletWhitelist {
    mapping(address => bool) private whitelist;
    event AddressAdded(address addedBy, address addedOf);
    event AddressRemoved(address removedBy, address removedOf);
    address public admin;

    constructor() {
        admin = msg.sender;
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
        whitelist[msg.sender] = true;
        emit AddressAdded(admin, addressToAdd);
    }

    function removeFromWhitelist(address addressToRemove) external onlyAdmin {
        require(addressToRemove != address(0), "address 0 not allowed");
        whitelist[msg.sender] = false;
        emit AddressRemoved(admin, addressToRemove);
    }
}
