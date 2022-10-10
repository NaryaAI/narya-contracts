// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "src/Token.sol";

contract ERC20TotalSupplyTest is PTest {
    address owner = address(0x1);

    Token token;
    uint256 totalSupply;

    function setUp() public {
        vm.startPrank(owner);
        token = new Token();
        totalSupply = token.totalSupply();
        vm.stopPrank();

        useDefaultAgent();
    }

    function invariantTotalSupplyShouldNeverChange() public view {
        assert(token.totalSupply() == totalSupply);
    }
}
