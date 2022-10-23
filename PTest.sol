// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Test.sol";
import "./ScriptEx.sol";
import "./Agent.sol";

contract PTest is Test, ScriptEx {
    Agent private _agent;

    function getAgent() public returns (address) {
        if (address(_agent) == address(0)) {
            _agent = new Agent();
        }
        return address(_agent);
    }
}
