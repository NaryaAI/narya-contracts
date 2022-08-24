// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Call {
    address to;
    bytes callData;
}

contract Agent {
    function test(Call[] calldata calls) external {
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, ) = calls[i].to.call(calls[i].callData);
            if (success) {
                this.check();
            }
        }
    }

    function callback(Call[] calldata calls) external payable {
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, ) = calls[i].to.call(calls[i].callData);
            if (success) {}
        }
    }

    function nop() external payable {}

    function check() external virtual {}
}

