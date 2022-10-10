// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "src/GameItems.sol";

contract ERC1155SafeTransferFromTest is PTest, IERC1155Receiver {
    address owner = address(0x1);
    address alice = address(0x927);

    GameItems gameItems;
    uint256 initAmount = 50;

    function setUp() public {
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

        useDefaultAgent();
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
        uint256 agentBalance = gameItems.balanceOf(agent, id);

        asAccountForNextCall(alice);
        gameItems.setApprovalForAll(agent, approved);

        gameItems.safeTransferFrom(alice, agent, id, amount, "");

        assert(approved);
        assert(amount <= initAmount && amount <= aliceBalance);
        assert(
            id == uint256(GameItems.Item.GOLD) ||
                id == uint256(GameItems.Item.SILVER)
        );
        assert(gameItems.balanceOf(alice, id) == aliceBalance - amount);
        assert(gameItems.balanceOf(agent, id) == agentBalance + amount);
    }

    /// @dev ERC1155Receiver interfaces
    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) external pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) external pure override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId)
        external
        pure
        returns (bool)
    {
        return interfaceId == type(IERC1155Receiver).interfaceId;
    }
}
