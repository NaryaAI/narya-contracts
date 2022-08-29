// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Call {
    address to;
    bytes callData;
}

contract Agent {
    function run(Call[] calldata calls) external {
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, ) = calls[i].to.call(calls[i].callData);
            if (success) {
                this.check();
            } else {
                return;
            }
        }
    }

    function _callback(Call[] calldata calls) internal {
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, ) = calls[i].to.call(calls[i].callData);
            if (!success) {
                return;
            }
        }
    }

    function onERC721Received(Call[] calldata calls) external returns (bytes4) {
        _callback(calls);
        return bytes4(0x150b7a02);
    } 

    function fallback(Call[] calldata calls) external payable {
        _callback(calls);
    }

    function callback(Call[] calldata calls) external {
        _callback(calls);
    }

    function check() external virtual {}
}
