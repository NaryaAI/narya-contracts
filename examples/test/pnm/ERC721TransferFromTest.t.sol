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

        asAccountBegin(owner);
        pfp = new PFP();
        id1 = pfp.mint(alice, "https://pnm.xyz/1");
        asAccountEnd();

        asAccountForNextCall(alice);
        pfp.approve(address(this), id2);
    }

    function testTransferFrom(uint256 id) public {
        try pfp.transferFrom(alice, address(this), id) {
            assert(id == id1);
            assert(pfp.ownerOf(id1) == address(this));
        } catch {
            assert(pfp.ownerOf(id1) == alice);
        }
    }

    function invariantSafeTransferFrom() public view {
        assert(pfp.ownerOf(id1) == alice);
    }
}
