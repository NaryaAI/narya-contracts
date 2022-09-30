// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "./Token.sol";

contract Vault is ERC4626 {
    constructor(IERC20 assset) ERC20("Valut", "VLT") ERC4626(assset) {
    }
}
