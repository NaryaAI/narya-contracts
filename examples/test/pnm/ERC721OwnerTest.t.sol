// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/PFP.sol";

contract ERC721OwnerTest is Agent {
    address user = address(0x927);
    PFP pfp;
    uint256 id;

    function setUp() public {
        address owner = address(0x1);

        asAccountBegin(owner);
        pfp = new PFP();
        id = pfp.mint(user, "https://pnm.xyz/1");
        asAccountEnd();
    }

    function invariantOwner() public view {
        assert(pfp.ownerOf(id) == user);
    }
}
