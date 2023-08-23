// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

pragma experimental ABIEncoderV2;

import {Test as ForgeTest} from "forge-std/Test.sol";
import {ScriptEx} from "./ScriptEx.sol";

contract Test is ForgeTest, ScriptEx {
    uint256 private constant AGENT_PRIVATE_KEY =
        uint256(keccak256("pnm.agent"));

    uint256 public agentCount = 1;

    function setAgentCount(uint256 count) internal {
        agentCount = count;
    }

    function getAgent() internal returns (address) {
        return vm.addr(AGENT_PRIVATE_KEY);
    }

    function getAgent(uint256 index) internal returns (address) {
        return vm.addr(AGENT_PRIVATE_KEY + index);
    }

    function getAgentKey() public pure returns (uint256) {
        return AGENT_PRIVATE_KEY;
    }
}
