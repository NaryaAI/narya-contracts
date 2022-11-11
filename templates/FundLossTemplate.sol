// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract FundLossTemplate is PTest {
    address protocol;
    address owner = makeAddr("owner");
    address user = makeAddr("user");
    address hacker;

    uint256 protocolInitValue;
    uint256 userInitValue;
    uint256 hackerInitValue;

    function setUp() public {
        hacker = getAgent();
        protocol = this.deploy();

        this.protocolInitValue = this.getTargetBalance(protocol);
        this.userInitValue = this.getTargetBalance(user);
        this.hackerInitValue = this.getTargetBalance(hacker);
    }

    function invariantCheckFund() public {
        checkFundIsSafe(protocol, protocolInitValue);
        checkFundIsSafe(user, userInitValue);

        checkFundNoGain(hacker, hackerInitValue);
    }

    // You need to define following functions for your test case

    // Deploy your contract here
    function deploy() public virtual returns (address);

    // This is where you define how to calculate the vaule you want to check
    function getTargetBalance(address target) public virtual returns (uint256);

    // Define criteria about fund loss checks
    function checkFundIsSafe(address target, uint256 initValue) public virtual;

    function checkFundNoGain(address target, uint256 initValue) public virtual;
}
