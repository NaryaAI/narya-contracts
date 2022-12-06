// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Test.sol";
import "./ScriptEx.sol";

contract PTest is Test, ScriptEx {
    address constant _agent =
        address(bytes20(uint160(uint256(keccak256("pnm.agent")))));

    function getAgent() public pure returns (address) {
        return _agent;
    }
}
