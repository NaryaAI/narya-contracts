// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "src/PFP.sol";

contract ERC721OwnerTest is PTest {
    address user = address(0x927);

    PFP pfp;
    uint256 id;

    function setUp() public {
        pfp = new PFP();
        id = pfp.mint(user, "https://pnm.xyz/1");
    }

    function invariantOwner() public view {
        assert(pfp.ownerOf(id) == user);
    }
}
