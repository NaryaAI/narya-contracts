// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20BalanceTest is Agent {
    address owner;
    address user;
    Token token;

    function setUp() public {
        owner = address(0x1);
        user = address(0x927);

        asAccountBegin(owner);
        token = new Token();
        token.transfer(user, 50);
        asAccountEnd();
    }

    function invariantBalanceShouldNotChange() public view {
        // User fund should be safe
        assert(token.balanceOf(user) == 50);
        // Hacker should not gain any fund in any way
        assert(token.balanceOf(address(this)) == 0);
    }
}
