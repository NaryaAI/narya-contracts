
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20TransferFromTest is Agent {
    address alice;
    address bob;
    Token token;

    function setUp() public {
        token = new Token();
        alice = address(0x927);
        bob = address(0x928);
        token.transfer(alice, 50);
        token.transfer(bob, 50);
        vm.prank(alice);
        token.approve(address(this), 20);
    }

    function testTransferFrom(uint amount) public {
        uint aliceBalance = token.balanceOf(alice);
        uint bobBalance = token.balanceOf(bob);
        uint allowance = token.allowance(alice, address(this));

        token.transferFrom(alice, bob, amount);

        assert(amount <= allowance);
        assert(token.balanceOf(alice) == aliceBalance - amount);
        assert(token.balanceOf(address(this)) == bobBalance + amount);
        assert(token.allowance(alice, address(this)) == allowance - amount);
    }
}