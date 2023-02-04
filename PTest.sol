// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Test.sol";
import "./ScriptEx.sol";

contract PTest is Test, ScriptEx {
    uint256 private constant AGENT_PRIVATE_KEY =
        uint256(keccak256("pnm.agent"));

    function getAgent() internal returns (address) {
        return vm.addr(AGENT_PRIVATE_KEY);
    }

    function getAgentKey() public pure returns (uint256) {
        return AGENT_PRIVATE_KEY;
    }
}
