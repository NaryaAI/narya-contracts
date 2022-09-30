// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/Agent.sol";
import "src/Token.sol";

contract ERC20TotalSupplyTest is Agent {
    address owner;
    Token token;

    uint256 totalSupply;

    function setUp() public {
        owner = address(0x1);

        vm.asAccountBegin(owner);
        token = new Token();
        vm.asAccountEnd();

        totalSupply = token.totalSupply();
    }

    function invariantTotalSupplyShouldNeverChange() public view {
        assert(token.totalSupply() == totalSupply);
    }
}
