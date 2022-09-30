// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/FuzzParameterTest.sol";
import {VulnerableDoor} from "src/VulnerableDoor.sol";

contract TargetParameterTest is FuzzParameterTest {
    address user;
    VulnerableDoor target;

    function setUp() public {
        user = 0x0000000000111111111100000000001111111111;
        target = new VulnerableDoor();

        // Call this function is you want to discard state changes after each test
        // vm.enableTestSideEffect(false);
    }

    // This function will be called again and again, with intellegently selected random data
    function testPaintColorAgainAndAgain(string memory color) external {
        require(bytes(color).length < 5);
        target.paint(color);
        assert(!target.stolen());
    }
}
