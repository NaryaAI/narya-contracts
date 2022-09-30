// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FuzzIntegrationTest} from "@pwnednomore/contracts/FuzzIntegrationTest.sol";
import {VulnerableDoor} from "src/VulnerableDoor.sol";

// A fuzz integration test runs in following patterns:
// 1. testContract.setup()
// 2. Call a random function in target contract, or a random `action_XXX` function in this test contract
// 3. testContract.test_XXX(), which is specified when this test runs
// 4. Goto step 2
contract TargetIntegrationTest is FuzzIntegrationTest {
    address user;
    ERC20 usdc_contract;
    VulnerableDoor target;

    function setUp() public {
        user = 0x0000000000111111111100000000001111111111;
        usdc_contract = new ERC20("USDC", "USDC");
        target = new VulnerableDoor();
    }

    // This function will be called randomly along with other methods in the target contract
    function actionAsUserAndOpenDoor() external {
      vm.startPrank(user);
      target.open(address(usdc_contract));
      vm.stopPrank();

      // Optional verifying
      assert(target.is_open());
    }

    // This is the verification method, which is called after every random actions
    function invariantDoorIsAlwaysSafe() external {
        assert(!target.stolen());
    }

    // You could define multiple test methods in one test suite,
    // but only one will be used for a single run
    function invariantYetAnotherTest() external {
        assert(!target.is_open());
    }

    // If any these functions accept parameters, we will feed in intellegently selected random data
    // For more structured data, you could write your own factory util functions
    // function test_doorCanAlwaysBePaint(string memory color) external {
    //     target.paint(color);
    //     require(keccak256(bytes(target.color())) == keccak256(bytes(color)));
    // }
}
