// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";
import "src/Vault.sol";

contract ERC4626RedeemTest is Agent {
    address alice = address(0x927);
    uint amount = 1;
    Vault vault;

    function setUp() public {
        address owner = address(0x1);
        vm.startPrank(owner);
        Token token = new Token();
        vault = new Vault();
        token.transfer(alice, 50);
        vm.stopPrank();

        vm.prank(alice);
        vault.mint(1, alice);
    }

    function invariantRedeem() public view {
        assert(vault.maxRedeem(alice) == amount);
        vault.redeem(amount, alice, alice);
        assert(vault.maxRedeem(alice) == 0);
    }
}