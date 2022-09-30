// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/GameItems.sol";

contract ERC1155SafeTransferFromTest is Agent {
    address alice = address(0x927);
    GameItems gameItems;
    uint256 initAmount = 50;

    function setUp() public {
        address owner = address(0x1);
        vm.startPrank(owner);
        gameItems = new GameItems();
        uint256[] memory items = new uint256[](2);
        items[0] = uint256(GameItems.Item.GOLD);
        items[1] = uint256(GameItems.Item.SILVER);
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = initAmount;
        amounts[1] = initAmount;
        gameItems.safeBatchTransferFrom(owner, alice, items, amounts, "");
        vm.stopPrank();
    }

    function testSafeTransferFrom(
        bool approved,
        GameItems.Item item,
        uint256 amount
    ) public {
        uint256 id = uint256(item);
        uint256 aliceBalance = gameItems.balanceOf(alice, id);
        uint256 agentBalance = gameItems.balanceOf(address(this), id);

        vm.prank(alice);
        gameItems.setApprovalForAll(address(this), approved);

        gameItems.safeTransferFrom(alice, address(this), id, amount, "");

        assert(approved);
        assert(amount <= initAmount && amount <= aliceBalance);
        assert(
            id == uint256(GameItems.Item.GOLD) ||
                id == uint256(GameItems.Item.SILVER)
        );
        assert(gameItems.balanceOf(alice, id) == aliceBalance - amount);
        assert(gameItems.balanceOf(address(this), id) == agentBalance + amount);
    }
}
