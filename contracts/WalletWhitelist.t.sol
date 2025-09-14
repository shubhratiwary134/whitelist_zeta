// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/WalletWhitelist.sol";

contract WalletWhiteListTest is Test {
    WalletWhitelist wallet;
    address admin;
    address[] initialAddresses;

    function setUp() public {
        admin = address(this);
        initialAddresses = [
            address(0x1),
            address(0x2),
            address(0x3),
            address(0x4),
            address(0x5)
        ];
    }

    function constructorTest() public {
        for (uint i = 0; i < initialAddresses.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit WalletWhitelist.AddressAdded(admin, initialAddresses[i]);
        }
        wallet = new WalletWhitelist(initialAddresses);
        assertEq(wallet.admin(), admin);

        for (uint i = 0; i < initialAddresses.length; i++) {
            assertTrue(wallet.isWhitelisted(initialAddresses[i]));
        }
    }
}
