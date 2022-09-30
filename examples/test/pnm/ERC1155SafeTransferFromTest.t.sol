// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/GameItems.sol";

contract ERC1155SafeTransferFromTest is Agent {
    address alice = address(0x927);
    GameItems gameItems;
    uint initAmount = 50;

    function setUp() public {
        address owner = address(0x1);
        vm.startPrank(owner);
        gameItems = new GameItems();
        gameItems.safeBatchTransferFrom(
            owner, 
            alice, 
            [GameItems.Item.GOLD, GameItems.Item.SILVER], 
            [initAmount, initAmount], 
            ""
        );
        vm.stopPrank();
    }

    function testSafeTransferFrom(bool approved, GameItems.Item item, uint amount) public {
        uint id = uint(item);
        uint aliceBalance = gameItems.balanceOf(alice, id);
        uint agentBalance = gameItems.balanceOf(address(this), id);

        vm.prank(alice);
        gameItems.setApprovalForAll(address(this), approved);

        gameItems.safeTransferFrom(alice, address(this), id, amount, "");

        assert(approved);
        assert(amount <= initAmount && amount <= aliceBalance);
        assert(id == unit(GameItems.GOLD) || id == uint(GameItems.SILVER));
        assert(gameItems.balanceOf(alice, id) == aliceBalance - amount);
        assert(gameItems.balanceOf(address(this), id) == agentBalance + amount);
    }
}
