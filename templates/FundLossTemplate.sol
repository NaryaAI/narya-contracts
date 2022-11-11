// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract FundLossTemplate is PTest {
    address protocol;
    address owner = makeAddr("owner");
    address user = makeAddr("user");
    address agent;

    uint256 protocolInitValue;
    uint256 userInitValue;
    uint256 agentInitValue;

    function setUp() public {
        agent = getAgent();
        protocol = this.deploy();

        protocolInitValue = this.getTargetBalance(protocol);
        userInitValue = this.getTargetBalance(user);
        agentInitValue = this.getTargetBalance(agent);
    }

    function invariantCheckFund() public {
        checkProtocolFundIsSafe(protocol, protocolInitValue);
        checkUserFundIsSafe(user, userInitValue);
        checkAgentFundNoGain(agent, agentInitValue);
    }

    // You need to define following functions for your test case

    // Deploy your contract here
    function deploy() public virtual returns (address);

    // This is where you define how to calculate the vaule you want to check
    function getTargetBalance(address target) public virtual returns (uint256);

    // Check fund status for each roles
    function checkProtocolFundIsSafe(address protocol, uint256 initValue) public virtual;
    function checkUserFundIsSafe(address user, uint256 initValue) public virtual;
    function checkAgentFundNoGain(address agent, uint256 initValue) public virtual;
}
