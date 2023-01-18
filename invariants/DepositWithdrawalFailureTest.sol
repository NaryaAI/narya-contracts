// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract DepositWithdrawalFailureTest is PTest {
    // Test setup.
    function setUp() public virtual {
        deploy();
        init();
    }

    // Deploys the smart contracts to be tested.
    function deploy() public virtual {}

    // Initializes user assets and calls deposit() to make deposit.
    function init() public virtual {}

    // Deposits user assets into the smart contract.
    function deposit() public virtual {}

    // Withdraws user assets from the smart contract.
    function withdraw() public virtual {}

    // Calls withdraw() and check if the asset balance of the user is not
    // smaller than the initial balance.
    function invariantDepositWithdrawalFailure() public virtual;
}
