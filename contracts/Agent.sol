// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./forge-std/Test.sol";
import "./forge-std/Vm.sol";
import "./VmEx.sol";

struct Call {
    address to;
    bytes callData;
}

contract Agent is Test, ScriptEx {
    event RevertedCall(bytes4 selector, uint256 index);

    bytes4 internal constant MAIN = bytes4(0x41414141);
    bytes4 internal constant FALLBACK = bytes4(0x00000000);
    bytes4 internal constant ON_ERC721_RECEIVED = bytes4(0x150b7a02);

    bytes internal invariantCalldata;

    function main(Call[] calldata calls) external {
        uint256 i;
        for (i = 0; i < calls.length; i++) {
            (bool succ, ) = calls[i].to.call(calls[i].callData);
            if (succ) {
                _testInvariant();
            } else {
                emit RevertedCall(MAIN, i);
                return;
            }
        }
    }

    function onERC721Received(Call[] calldata calls) external returns (bytes4) {
        _callback(ON_ERC721_RECEIVED, calls);
        return ON_ERC721_RECEIVED;
    }

    function fallback(Call[] calldata calls) external payable {
        _callback(FALLBACK, calls);
    }

    function callback(bytes4 selector, Call[] calldata calls) external {
        _callback(selector, calls);
    }

    function setInvariant(bytes calldata _invariantCalldata) external {
        invariantCalldata = _invariantCalldata;
    }

    function _testInvariant() internal {
        (bool success, bytes memory result) = address(this).call(invariantCalldata);

        if (!success) {
            if (result.length < 68) revert();
            assembly {
                result := add(result, 0x04)
            }
            revert(abi.decode(result, (string)));
        }
    }

    function _callback(bytes4 selector, Call[] calldata calls) internal {
        uint256 i;
        for (i = 0; i < calls.length; i++) {
            (bool success, ) = calls[i].to.call(calls[i].callData);
            if (!success) {
                emit RevertedCall(selector, i);
                return;
            }
        }
    }
}
