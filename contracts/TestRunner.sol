// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./interfaces/IPTest.sol";
import "./interfaces/IAgent.sol";
import "./ScriptEx.sol";

contract TestRunner is ScriptEx {
    event RevertedCall(bytes4 selector, uint256 index);
    bytes4 internal constant MAIN = bytes4(0xffffffff);

    address test;
    address agent;

    bytes internal invariantCalldata;

    constructor(address _test, address _agent) {
        test = _test;
        agent = _agent;
    }

    function setUp() public {
        IPTest(test).setUp(agent);
    }

    function setInvariant(bytes calldata _invariantCalldata) external {
        invariantCalldata = _invariantCalldata;
    }

    function testInvariant(Call[] calldata calls) public {
        uint256 i;
        for (i = 0; i < calls.length; i++) {
            vm.prank(agent);
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

    function testFunction(bytes calldata callData) public {
        vm.prank(test);
        (bool success, bytes memory result) = test.call(callData);
        if (!success && isPanic(result)) {
            revert();
        }
    }

    function checkInvariant() internal {
        vm.prank(test);
        (bool success, bytes memory result) = test.call(invariantCalldata);

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
