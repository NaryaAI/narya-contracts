// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/basic/Flag.sol";
import "@pwnednomore/contracts/Agent.sol";

contract FlagTest is Agent {
    Flag flag;

    function setUp() external {
        flag = new Flag();
    }

    function testSetFlags(int256 x, int256 y) external {
        flag.set0(x);
        flag.set1(y);
        assert(flag.flag1());
    }

    function invariantFlagIsTrue() external view {
        assert(flag.flag1());
    }
}
