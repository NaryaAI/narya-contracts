// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "src/Token.sol";

contract ERC20TransferTest is PTest {
    address owner = address(0x1);
    address user = address(0x927);
    Token token;

    function setUp() public {
        asAccountBegin(owner);
        token = new Token();
        token.transfer(user, 50);
        asAccountEnd();
    }

    function testTransfer(uint256 amount) public {
        address receiver = address(0x928);
        uint256 userBalance = token.balanceOf(user);
        uint256 receiverBalance = token.balanceOf(receiver);

        asAccountForNextCall(user);
        try token.transfer(receiver, amount) {
            assert(amount <= userBalance);
            assert(token.balanceOf(user) == userBalance - amount);
            assert(token.balanceOf(receiver) == receiverBalance + amount);
        } catch {
            assert(token.balanceOf(user) == userBalance);
            assert(token.balanceOf(receiver) == receiverBalance);
        }
    }
}
