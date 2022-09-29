
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20TotalSupplyTest is Agent {
    Token token;
    uint totalSupply;

    function setUp() public {
        token = new Token();
        totalSupply = token.totalSupply();
    }

    function invariantTotalSupply() public view {
        assert(token.totalSupply() == totalSupply);
    }
}