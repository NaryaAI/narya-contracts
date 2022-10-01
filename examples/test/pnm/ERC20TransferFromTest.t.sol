// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20TransferFromTest is Agent {
    address alice = address(0x927);
    Token token;

    function setUp() public {
        address owner = address(0x1);

        asAccountBegin(owner);
        token = new Token();
        token.transfer(alice, 50);
        asAccountEnd();

        asAccountForNextCall(alice);
        token.approve(address(this), 20);
    }

    function testTransferFrom(uint256 amount) public {
        uint256 aliceBalance = token.balanceOf(alice);
        uint256 agentBalance = token.balanceOf(address(this));
        uint256 allowance = token.allowance(alice, address(this));

        try token.transferFrom(alice, address(this), amount) {
            assert(amount <= aliceBalance);
            assert(amount <= allowance);
            assert(token.balanceOf(alice) == aliceBalance - amount);
            assert(token.balanceOf(address(this)) == agentBalance + amount);
            assert(token.allowance(alice, address(this)) == allowance - amount);
        } catch {
            assert(token.balanceOf(alice) == aliceBalance);
            assert(token.balanceOf(address(this)) == agentBalance);
            assert(token.allowance(alice, address(this)) == allowance);
        }
    }
}
