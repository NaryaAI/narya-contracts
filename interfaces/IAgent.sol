// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

struct Call {
    address to;
    bytes callData;
}

interface IAgent {
    event RevertedCall(bytes4 selector, uint256 index);
}
