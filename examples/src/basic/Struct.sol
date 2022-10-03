// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

struct Param {
    int256 a;
    int256 b;
}

contract Struct {
    bool public flag0 = true;
    bool public flag1 = true;

    function set0(Param calldata param) public returns (bool) {
        if (param.a % 100 == 0 && param.b % 200 == 0) flag0 = false;
        return flag0;
    }

    function set1(Param calldata param) public returns (bool) {
        if (param.a % 10 == 0 && param.b % 20 == 0 && !flag0) flag1 = false;
        return flag1;
    }
}
