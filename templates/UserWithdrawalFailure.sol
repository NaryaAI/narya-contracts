// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract DepositWithdrawalFailureTest is PTest {
    address internal user = makeAddr("USER");

    // Test setup.
    function setUp() public {
        deploy();
        init();
    }

    // Deploy the smart contracts to be tested.
    function deploy() public virtual;

    // Initialize user assets and make deposits.
    // You should call deposit() in this function.
    function init() public virtual;

    // Deposit user assets into the smart contract.
    function deposit() public virtual;

    // Withdraw user assets from the smart contract.
    function withdraw() public virtual;

    // Check if at any time, user can withdraw the amount of assets once deposited.
    function invariantUserWithdrawalFailure() public virtual;
}
