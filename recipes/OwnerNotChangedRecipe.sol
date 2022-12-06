// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract OwnerNotChangedRecipe is PTest {
    address owner = makeAddr("owner");

    function setUp() public {
        this.deploy();
    }

    function invariantOwnerNotChanged() public {
        require(this.getOwner() == owner, "Ownership changes!");
    }

    // [Require] You need to define following functions for your test case

    // Define how to deploy the contract(s) to be tested
    function deploy() public virtual returns (address);

    // Define how to get current ownership
    function getOwner() public virtual returns (address);
}
