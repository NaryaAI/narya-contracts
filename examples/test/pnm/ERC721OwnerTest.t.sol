// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/PFP.sol";

contract ERC721OwnerTest is Agent {
    address alice = address(0x927);
    PFP pfp;
    uint256 id;

    function setUp() public {
        address owner = address(0x1);
        vm.startPrank(owner);
        pfp = new PFP();
        id = pfp.mint(alice, "https://pnm.xyz/1");
        vm.stopPrank();
    }

    function invariantOwner() public view {
        assert(pfp.ownerOf(id) == alice);
    }
}
