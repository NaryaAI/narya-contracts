// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract UnboundedProfitTest is PTest {
    uint256 internal oldBalance;
    uint256 internal constant DEFAULT_LIMIT = 101;

    // Test setup.
    function setUp() public {
        deploy();
        init();
    }

    // Deploy the smart contracts to be tested.
    function deploy() public virtual;

    // Initialize the states of the smart contracts.
    function init() public virtual;

    // Gets the current balance of the agent.
    function getBalance() public virtual returns (uint256);

    // Records the initial balance of the agent.
    function initBalance() public {
        oldBalance = getBalance();
    }

    // Gets the profit limit.
    // The upper bound of the profit = the initial balance * limit / 100.
    function getLimit() public virtual returns (uint256) {
        return DEFAULT_LIMIT;
    }

    function invariantUnboundedProfit() public virtual {
        uint256 newBalance = getBalance();

        if (oldBalance == 0) {
            assert(newBalance == 0);
        } else {
            assert(newBalance <= (oldBalance * getLimit()) / 100);
        }
    }
}
