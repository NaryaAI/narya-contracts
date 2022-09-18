// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/Agent.sol";
import "./Target.sol";

contract TestDoor is Agent {
    Target target;

    function setUp() public {
        target = new Target();
    }

    function check() external view override {
        require(!target.stolen(), "stolen");
    }
}
