// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/FuzzParameterTest.sol";
import  "src/Target.sol";

contract TargetParameterTest is FuzzParameterTest {
    address user;
    Target target;

    function setUp() public {
        user = 0x0000000000111111111100000000001111111111;
        target = new Target();

        // Call this function is you want to discard state changes after each test
        // vm.enableTestSideEffect(false);
    }

    // This function will be called again and again, with intellegently selected random data
    function test(string memory color) external {
        require(bytes(color).length < 5);
        target.paint(color);
        assert(!target.stolen());
    }
}
