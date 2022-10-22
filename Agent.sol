// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./interfaces/IAgent.sol";
import "./ScriptEx.sol";

contract Agent is ScriptEx {
    event RevertedCall(bytes4 selector, uint256 index);

    bytes4 internal constant FALLBACK = bytes4(0x00000000);
    bytes4 internal constant ON_ERC721_RECEIVED = bytes4(0x150b7a02);

    function call(Call calldata c) external payable {
        (bool success, bytes memory result) = c.to.call(c.callData);
        if (!success) {
            if (result.length < 68) revert();
            assembly {
                result := add(result, 0x04)
            }
            revert(abi.decode(result, (string)));
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

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) external pure returns (bytes4) {
        return this.onERC1155BatchReceived.selector; // 0xbc197c81
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) external pure returns (bytes4) {
        return this.onERC1155Received.selector; // 0xf23a6e61
    }
}
