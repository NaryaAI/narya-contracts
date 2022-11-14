// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PTest} from "../PTest.sol";

abstract contract WithdrawWhatDepositRecipe is PTest {
    address user = makeAddr("user");
    uint256 userInitValue;

    function setUp() public {
        this.deploy();

        userInitValue = this.getTargetBalance(user);

        this.deposit(user, userInitValue);
    }

    function invariantWithdrawWhatDeposit() public {
        this.withdraw(user, userInitValue);
        checkUserFundIsSafe(user, userInitValue);
    }

    // [Require] You need to define following functions for your test case

    // Define how to deploy the contract(s) to be tested
    function deploy() public virtual returns (address);

    // Define how to calculate the vaule you want to check
    function getTargetBalance(address target) public virtual returns (uint256);

    // Define how to deposit given amount as a user
    function deposit(address user, uint256 value) public virtual;

    // Define how to withdraw
    function withdraw(address user, uint256 value) public virtual;

    // [Optional] You could override following functions to define your own logic

    function checkUserFundIsSafe(address user, uint256 initValue)
        public
        virtual
    {
        uint256 currentValue = this.getTargetBalance(user);
        require(currentValue >= initValue, "User balance is reduced");
    }
}
