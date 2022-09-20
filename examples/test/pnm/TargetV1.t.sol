// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@pwnednomore/contracts/Agent.sol";
import "contracts/Target.sol";

contract TargetTest is Agent {
    Target target;

    function setUp() public {
        target = new Target();
    }

    function test() external {
        require(!target.stolen(), "stolen");
        console.log("Test success");
    }
}
