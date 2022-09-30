// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./forge-std/Vm.sol";

interface VmHelpers is Vm {

    // Sets the *next* call's msg.sender to be the input address
    function asAccountForNextCall(address addr) external {
        prank(addr);
    }
    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function asAccountForNextCall(address addr, address origin) external {
        prank(addr, origin);
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function asAccountBegin(address addr) external {
        startPrank(addr);
    }
    function asAccountBegin(address addr, address origin) external {
        startPrank(addr, origin);
    }
    // Resets subsequent calls' msg.sender to be `address(this)`
    function asAccountEnd() external {
        stopPrank();
    }

}
