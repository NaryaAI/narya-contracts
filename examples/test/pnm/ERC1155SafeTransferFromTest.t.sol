// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "src/GameItems.sol";
import {console} from "@pwnednomore/contracts/forge-std/console.sol";

contract ERC1155SafeTransferFromTest is Agent, IERC1155Receiver {
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
        // bool approved, // add it back in PNM engine.
        // GameItems.Item item, // add it back in PNM engine.
        uint256 amount
    ) public {
        vm.assume(amount <= initAmount && amount > 0); // remove this in PNM engine.
        bool approved = true; // remove this in PNM engine.
        GameItems.Item item = GameItems.Item.GOLD; // remove this in PNM engine.

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

    /// @dev ERC1155Receiver interfaces
    function onERC1155Received(
        address operator, 
        address from, 
        uint256 id, 
        uint256 value, 
        bytes memory data
    ) external override returns (bytes4){
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator, 
        address from, 
        uint256[] memory ids, 
        uint256[] memory values, 
        bytes memory data
    ) external override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return interfaceId == type(IERC1155Receiver).interfaceId;
    }
}
