
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20TransferTest is Agent {
    address alice;
    Token token;

    function setUp() public {
        token = new Token();
        alice = address(0x927);
    }

    function testTransfer(uint amount) public {
        uint aliceBalance = token.balanceOf(alice);
        uint agentBalance = token.balanceOf(address(this));

        token.transfer(alice, amount);

        assert(amount <= aliceBalance);
        assert(token.balanceOf(alice) == aliceBalance + amount);
        assert(token.balanceOf(address(this)) == agentBalance - amount);
    }
}