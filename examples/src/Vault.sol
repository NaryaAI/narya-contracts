// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "./Token.sol";

contract Vault is ERC4626 {
    constructor() ERC4626(Token) {
    }
}
