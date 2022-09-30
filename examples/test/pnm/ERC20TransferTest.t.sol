// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20TransferTest is Agent {
    address owner;
    address user;
    Token token;

    function setUp() public {
        owner = address(0x1);
        user = address(0x927);

        vm.asAccountBegin(owner);
        token = new Token();
        token.transfer(user, 50);
        vm.asAccountEnd();
    }

    function testTransfer(uint256 amount) public {
        vm.assume(amount <= 50);

        address receiver = address(0x928);
        uint256 userBalance = token.balanceOf(user);
        uint256 receiverBalance = token.balanceOf(receiver);

        token.transfer(user, amount);

        assert(amount <= userBalance);
        assert(token.balanceOf(user) == userBalance + amount);
        assert(token.balanceOf(receiver) == receiverBalance - amount);
    }
}
