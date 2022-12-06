// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Test.sol";
import "./ScriptEx.sol";

contract PTest is Test, ScriptEx {
    address constant agent =
        address(bytes20(uint160(uint256(keccak256("pnm.agent")))));
}
