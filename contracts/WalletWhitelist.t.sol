// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/WalletWhitelist.sol";

contract WalletWhiteListTest is Test {
    WalletWhitelist wallet;
    address admin;
    address[5] initialAddresses;

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

    function test_Constructor() public {
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

    function test_AddToWhiteList_Success() public {
        wallet = new WalletWhitelist(initialAddresses);

        address newAddress = address(0x10);

        vm.expectEmit(true, true, false, true);
        emit WalletWhitelist.AddressAdded(admin, newAddress);

        wallet.addToWhitelist(newAddress);

        assertTrue(wallet.isWhitelisted(newAddress));
    }

    function test_AddToWhitelist_failIfNotAdmin() public {
        wallet = new WalletWhitelist(initialAddresses);

        address newAddress = address(0x11);

        vm.prank(address(0x999));
        vm.expectRevert("not admin");
        wallet.addToWhitelist(newAddress);
    }

    function test_AddToWhitelist_failIfAddressIsZero() public {
        wallet = new WalletWhitelist(initialAddresses);

        vm.expectRevert("address 0 not allowed");
        wallet.addToWhitelist(address(0));
    }

    function test_AddToWhitelist_failIfAlreadyWhitelisted() public {
        wallet = new WalletWhitelist(initialAddresses);

        address alreadyWhitelisted = initialAddresses[0];

        vm.expectRevert("Address already whitelisted");
        wallet.addToWhitelist(alreadyWhitelisted);
    }

    function test_RemoveFromWhitelist_Success() public {
        wallet = new WalletWhitelist(initialAddresses);

        address newAddress = initialAddresses[0];

        vm.expectEmit(true, true, false, true);
        emit WalletWhitelist.AddressRemoved(admin, newAddress);

        wallet.removeFromWhitelist(newAddress);

        assertFalse(wallet.isWhitelisted(newAddress));
    }

    function test_RemoveFromWhitelist_failIfNotAdmin() public {
        wallet = new WalletWhitelist(initialAddresses);

        address target = initialAddresses[1];

        vm.prank(address(0x999));
        vm.expectRevert("not admin");
        wallet.removeFromWhitelist(target);
    }

    function test_RemoveFromWhitelist_failIfAddressIsZero() public {
        wallet = new WalletWhitelist(initialAddresses);

        vm.expectRevert("address 0 not allowed");
        wallet.removeFromWhitelist(address(0));
    }

    function test_RemoveFromWhitelist_failIfNotWhitelisted() public {
        wallet = new WalletWhitelist(initialAddresses);

        address notWhitelisted = address(0x123);

        vm.expectRevert("Address is already not whitelisted");
        wallet.removeFromWhitelist(notWhitelisted);
    }
}
