// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IUUPSUpgradeableMock {
    function flag0() external view returns (bool);

    function flag1() external view returns (bool);

    function set0(int256 val) external returns (bool);

    function set1(int256 val) external returns (bool);
}
