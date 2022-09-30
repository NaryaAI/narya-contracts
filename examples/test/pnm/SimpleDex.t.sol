// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/Agent.sol";
import {SimpleDex} from "src/SimpleDex.sol";
import {Token} from "src/Token.sol";

contract SimpleDexTest is Agent {
    Token token;
    SimpleDex target;

    function setUp() public {
        token = new Token();
        target = new SimpleDex(address(token));
        target.init(10000);
    }

    function invariantProtocolBalanceShouldAlwaysBeSafe() external {
        require(token.balanceOf(address(this)) >= 10000, "stolen");
        console.log("Test success");
    }
}
