// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract UUPSUpgradeableMock is Initializable, UUPSUpgradeable {
    bool public flag0;
    bool public flag1;

    function initialize() public initializer {
        flag0 = true;
        flag1 = true;
    }

    function set0(int256 val) public returns (bool) {
        if (val % 100 == 0) flag0 = false;
        return flag0;
    }

    function set1(int256 val) public returns (bool) {
        if (val % 10 == 0 && !flag0) flag1 = false;
        return flag1;
    }

    function _authorizeUpgrade(address) internal override {}
}
