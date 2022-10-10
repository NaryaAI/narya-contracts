// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@pwnednomore/contracts/PTest.sol";
import "src/Token.sol";
import "src/Vault.sol";

contract ERC4626RedeemTest is PTest {
    address owner = address(0x1);
    address alice = address(0x927);

    uint256 amount = 1;

    Vault vault;

    function setUp() public {
        vm.startPrank(owner);
        Token token = new Token();
        vault = new Vault(token);
        token.transfer(alice, 50);
        vm.stopPrank();

        asAccountForNextCall(alice);
        vault.mint(1, alice);

        useDefaultAgent();
    }

    function invariantRedeem() external {
        assert(vault.maxRedeem(alice) == amount);
        vault.redeem(amount, alice, alice);
        assert(vault.maxRedeem(alice) == 0);
    }
}
