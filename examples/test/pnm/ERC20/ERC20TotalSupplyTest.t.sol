// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "src/Token.sol";

contract ERC20TotalSupplyTest is PTest {
    Token token;
    uint256 totalSupply;

    address agent;

    function setUp(address _agent) public override {
        agent = _agent;

        token = new Token();
        totalSupply = token.totalSupply();
    }

    function invariantTotalSupplyShouldNeverChange() public view {
        assert(token.totalSupply() == totalSupply);
    }
}
