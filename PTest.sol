// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Test.sol";
import "./ScriptEx.sol";
import "./Agent.sol";

contract PTest is Test, ScriptEx {
    address public agent;

    function useAgent(address _agent) public {
        agent = _agent;
    }

    function useDefaultAgent() public {
        useAgent(address(new Agent()));
    }
}
