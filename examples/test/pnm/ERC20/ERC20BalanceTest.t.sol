// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "src/Token.sol";

contract ERC20BalanceTest is PTest {
    address owner = address(0x1);
    address user = address(0x927);

    Token token;

    function setUp() public {
        vm.startPrank(owner);
        token = new Token();
        token.transfer(user, 50);
        vm.stopPrank();

        useDefaultAgent();
    }

    function invariantBalanceShouldNotChange() public view {
        // User fund should be safe
        assert(token.balanceOf(user) == 50);
        // Hacker should not gain any fund in any way
        assert(token.balanceOf(agent) == 0);
    }
}
