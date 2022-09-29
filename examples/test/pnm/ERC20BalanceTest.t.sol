// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20BalanceTest is Agent {
    address alice;
    address owner;
    Token token;

    function setUp() public {
        owner = address(0x1);
        alice = address(0x927);

        vm.startPrank(owner);
        token = new Token();
        token.transfer(alice, 50);
        vm.stopPrank();
    }

    function invariantBalance() public view {
        assert(token.balanceOf(alice) == 50);
    }
}
