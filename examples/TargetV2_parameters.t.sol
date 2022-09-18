// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/FuzzTest.sol";
import "./Target.sol";

contract DoorTest is FuzzParameterTest {
    address user;
    Target target;

    function setup() public {
        user = vm.getRandomAddress();
        target = new Target();

        // Call this function is you want to discard state changes after each test
        vm.enableTestSideEffect(false);
    }

    // This function will be called again and again, with intellegently selected random data
    function test_paintColorAgainAndAgain(string memory color) external {
        target.paint(color);
        require(!target.stolen(), "TestReport: Door is stolen!");
    }
}
