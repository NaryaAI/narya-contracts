// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./forge-std/Test.sol";
import "./ScriptEx.sol";
import "./Agent.sol";

contract PTest is Test, ScriptEx {
    event RevertedCall(bytes4 selector, uint256 index);

    bytes4 internal constant MAIN = bytes4(0xffffffff);

    Agent public agent;
    bytes internal invariantCalldata;

    function useAgent(Agent _agent) public {
        agent = _agent;
    }

    function useDefaultAgent() public {
        useAgent(new Agent());
    }

    function callAgent(Call[] calldata calls) public {
        uint256 i;
        for (i = 0; i < calls.length; i++) {
            vm.prank(address(agent));
            (bool success, bytes memory result) = calls[i].to.call(
                calls[i].callData
            );

            if (success) {
                checkInvariant();
            } else if (isPanic(result)) {
                revert();
            } else {
                emit RevertedCall(MAIN, i);
                return;
            }
        }
    }

    function useInvariant(bytes calldata _invariantCalldata) public {
        invariantCalldata = _invariantCalldata;
    }

    function checkInvariant() internal {
        (bool success, bytes memory result) = address(this).call(
            invariantCalldata
        );

        if (!success) {
            if (result.length < 68) revert();
            assembly {
                result := add(result, 0x04)
            }
            revert(abi.decode(result, (string)));
        }
    }

    function isPanic(bytes memory result) internal pure returns (bool) {
        bytes4 selector;
        assembly {
            selector := mload(add(result, 0x20))
        }
        return selector == bytes4(0x4e487b71); // Panic(uint256)
    }
}
