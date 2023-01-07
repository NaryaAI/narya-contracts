// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract UnprotectedOwnershipTest is PTest {
    address internal owner;

    // Test setup.
    function setUp() public {
        deploy();
        init();
    }

    // Deploy the smart contracts to be tested.
    function deploy() public virtual;

    // Return the current owner of your smart contract.
    function getOwner() public virtual returns (address);

    // Initialize your smart contracts
    function init() public virtual {
        owner = getOwner();
    }

    // Check the owner of your smart contract is not changed
    function invariantUnprotectedOwnership() public virtual {
        assert(getOwner() == owner);
    }
}
