// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/Agent.sol";
import "contracts/Target.sol";

contract TestDoor is Agent {
    Target target;

    function setUp() public {
        target = new Target();
    }

    function test() external {
        require(!target.stolen(), "stolen");
    }
}
