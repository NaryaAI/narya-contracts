// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "src/proxy/UUPSUpgradeableMock.sol";
import "src/interfaces/IUUPSUpgradeableMock.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@pwnednomore/contracts/PTest.sol";

contract FlagUpgradeableTest is PTest {
    ERC1967Proxy proxy;
    UUPSUpgradeableMock mock;

    function setUp() public {
        mock = new UUPSUpgradeableMock();
        proxy = new ERC1967Proxy(
            address(mock),
            abi.encodeWithSignature("initialize()")
        );

        useDefaultAgent();
    }

    // flag1 should always be true
    function testSetFlags(int256 x, int256 y) public {
        IUUPSUpgradeableMock(address(proxy)).set0(x);
        IUUPSUpgradeableMock(address(proxy)).set1(y);
        assert(IUUPSUpgradeableMock(address(proxy)).flag1());
    }

    function invariantFlagIsTrue() public view {
        assert(IUUPSUpgradeableMock(address(proxy)).flag1());
    }
}
