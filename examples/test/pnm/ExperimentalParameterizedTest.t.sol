// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/FuzzParameterTest.sol";
import {VulnerableDoor} from "src/callback/VulnerableDoor.sol";

contract ParameterizedTest is FuzzParameterTest {
    address user = address(0x37);
    VulnerableDoor target;

    function setUp() public {
        target = new VulnerableDoor();

        // Call this function is you want to discard state changes after each test
        // vm.enableTestSideEffect(false);
    }

    // This function will be called again and again, with intellegently selected random data
    function testPaintColorAgainAndAgain(string memory color) external {
        vm.assume(bytes(color).length < 5);
        target.paint(color);
        assert(!target.stolen());
    }
}
