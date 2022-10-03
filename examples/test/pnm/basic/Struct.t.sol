// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/basic/Struct.sol";
import "@pwnednomore/contracts/Agent.sol";

contract StructTest is Agent {
    Struct st;

    function setUp() external {
        st = new Struct();
    }

    function testSetFlags(Param calldata x, Param calldata y) external {
        st.set0(x);
        st.set1(y);
        assert(st.flag1());
    }

    function invariantFlagIsTrue() external view {
        assert(st.flag1());
    }
}
