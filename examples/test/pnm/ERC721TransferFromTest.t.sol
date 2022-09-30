// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/PFP.sol";

contract ERC721TransferFromTest is Agent {
    address alice = address(0x927);
    PFP pfp;
    uint256 id1;
    uint256 id2;

    function setUp() public {
        address owner = address(0x1);
        vm.startPrank(owner);
        pfp = new PFP();
        id1 = pfp.mint(alice, "https://pnm.xyz/1");
        id2 = pfp.mint(alice, "https://pnm.xyz/2");
        vm.stopPrank();

        vm.prank(alice);
        pfp.approve(address(this), id2);
    }

    function testTransferFrom(uint256 id) public {
        vm.assume(id == id2); // remove this for PNM engine

        pfp.transferFrom(alice, address(this), id);
        assert(id == id2);
        assert(pfp.ownerOf(id) == address(this));
    }

    function invariantSafeTransferFrom() public view {
        assert(pfp.ownerOf(id1) == alice);
    }
}
