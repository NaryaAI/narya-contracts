// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/basic/Flag.sol";
import "@pwnednomore/contracts/PTest.sol";

contract FlagTest is PTest {
    Flag flag;

    function setUp() public {
        flag = new Flag();

        useDefaultAgent();
    }

    function testSetFlags(int256 x, int256 y) public {
        flag.set0(x);
        flag.set1(y);
        assert(flag.flag1());
    }

    function invariantFlagIsTrue() public view {
        assert(flag.flag1());
    }
}
