// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./forge-std/Test.sol";
import "./forge-std/Vm.sol";
import "./ScriptEx.sol";
import "./VmEx.sol";
import "./Agent.sol";

abstract contract PTest is Test, ScriptEx {
    function setUp(address agent) public virtual;
}
