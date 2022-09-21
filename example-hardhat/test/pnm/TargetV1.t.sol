// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/Agent.sol";
// Notice that Target contract uses hardhat console
// which is conflict with our Agent contract's console.
// So we need to explicitly import symbol here to
// avoid importing two console contracts to the global namespace.
import {Target} from "contracts/Target.sol";

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
