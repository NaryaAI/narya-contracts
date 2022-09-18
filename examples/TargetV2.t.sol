// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/FuzzTest.sol";
import "./Target.sol";

// A fuzz integration test runs in following patterns:
// 1. testContract.setup()
// 2. Call a random function in target contract, or a random `action_XXX` function in this test contract
// 3. testContract.test_XXX(), which is specified when this test runs
// 4. Goto step 2
contract DoorTest is FuzzIntegrationTest {
    address user;
    address usdc_contract;
    Target target;

    function setup() public {
        user = vm.getRandomAddress();
        usdc_contract = new ERC20();
        target = new Target();
    }

    // This function will be called randomly along with other methods in the target contract
    function action_asUser_openDoor() external {
      vm.changeCaller(user);
      target.open_door(usdc_contract);
      vm.restoreCaller();

      // Optional verifying
      require(target.open_door(), "TestReport: Door should be open after user opens it");
    }

    // This is the verification method, which is called after every random actions
    function test_doorIsAlwaysSafe() external {
        require(!target.stolen(), "TestReport: Door is stolen!");
    }

    // You could define multiple test methods in one test suite,
    // but only one will be used for a single run
    function test_anotherTest() external {
        require(!target.open_door(), "This test is not used");
    }

    // If any these functions accept parameters, we will feed in intellegently selected random data
    // For more structured data, you could write your own factory util functions
    function test_doorCanAlwaysBePaint(string memory color) external {
        target.paint(color);
        require(target.color() == color, "TestReport: Door paint failed!");
    }
}
