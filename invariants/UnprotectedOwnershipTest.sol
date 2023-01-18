// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract UnprotectedOwnershipTest is PTest {
    address internal oldOwner;

    // Test setup.
    function setUp() public virtual {
        deploy();
        init();
    }

    // Deploys the smart contracts to be tested.
    function deploy() public virtual {}

    // Initializes the owner of the smart contract if not set and
    // calls initOwner().
    function init() public virtual {}

    // Return the current owner of your smart contract.
    function getOwner() public virtual returns (address);

    // Records the initial owner of your smart contract.
    function initOwner() public virtual {
        oldOwner = getOwner();
    }

    // Check if the owner of your smart contract is changed.
    function invariantUnprotectedOwnership() public virtual {
        assert(getOwner() == oldOwner);
    }
}
