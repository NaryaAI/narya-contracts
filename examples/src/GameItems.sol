// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract GameItems is ERC1155 {
    enum Item { GOLD, SILVER, THORS_HAMMER, SWORD, SHIELD }

    constructor() ERC1155("https://game.example/api/item/{id}.json") {
        _mint(msg.sender, uint(Item.GOLD), 10**18, "");
        _mint(msg.sender, uint(Item.SILVER), 10**27, "");
        _mint(msg.sender, uint(Item.THORS_HAMMER), 1, "");
        _mint(msg.sender, uint(Item.SWORD), 10**9, "");
        _mint(msg.sender, uint(Item.SHIELD), 10**9, "");
    }
}
