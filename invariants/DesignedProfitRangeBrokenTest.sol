// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract DesignedProfitRangeBrokenTest is PTest {
    uint256 internal oldBalance;
    uint256 internal constant DEFAULT_LIMIT = 101;

    // Test setup.
    function setUp() public virtual {
        deploy();
        init();
    }

    // Deploys the smart contracts to be tested.
    function deploy() public virtual {}

    // 1. Adding assets to the smart contracts.
    // 2. Initializes the initial assets for the agent and calls initBalance().
    function init() public virtual {}

    // Returns the total value of the assets owned by the agent.
    function getBalance() public virtual returns (uint256);

    // Records the initial balance of the agent.
    function initBalance() public {
        oldBalance = getBalance();
    }

    // Gets the upper limit of the profit gained by the agent.
    // By default, it is 1%.
    function getLimit() public virtual returns (uint256) {
        return DEFAULT_LIMIT;
    }

    // The asset balane of the agent should not:
    // 1. Increase from 0 to any positive number.
    // 2. Increase by 1%.
    function invariantDesignedProfitRangeBroken() public virtual {
        uint256 newBalance = getBalance();

        if (oldBalance == 0) {
            assert(newBalance == 0);
        } else {
            assert(newBalance <= (oldBalance * getLimit()) / 100);
        }
    }
}
