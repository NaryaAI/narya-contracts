// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/PTest.sol";
import {SimpleDex} from "src/SimpleDex.sol";
import {Token} from "src/Token.sol";

contract SimpleDexTest is PTest {
    address owner = address(0x1);
    address lp = address(0x37);
    address user = address(0x38);

    Token token;
    SimpleDex target;

    function setUp() public {
        useDefaultAgent();

        vm.startPrank(owner);

        // Setup DEX with 10ETH and 10Token
        token = new Token();
        setNativeBalance(address(token), 10);
        target = new SimpleDex(address(token));
        token.increaseAllowance(address(target), 10);
        target.init(10);

        // Give all roles 10ETH and 10Token
        setNativeBalance(lp, 10);
        token.transfer(lp, 10);

        setNativeBalance(user, 10);
        token.transfer(user, 10);

        setNativeBalance(agent, 10);
        token.transfer(agent, 10);

        vm.stopPrank();
    }

    function actionLpDeposit(uint256 amount) public {
        asAccountForNextCall(lp);
        target.deposit{value: amount}();
    }

    function actionLpWithdraw(uint256 amount) public {
        asAccountForNextCall(lp);
        target.withdraw(amount);
    }

    function actionUserSwapFromEthToToken(uint256 amount) public {
        asAccountForNextCall(user);
        target.ethToToken{value: amount}();
    }

    function actionUserSwapFromTokenToEth(uint256 amount) public {
        asAccountForNextCall(user);
        target.tokenToEth(amount);
    }

    function invariantProtocolBalanceShouldAlwaysBeSafe() public view {
        address protocol = address(target);
        assert(token.balanceOf(protocol) + protocol.balance >= 20);
    }

    function invariantHackerCanNotGainToken() public view {
        assert(agent.balance <= 20);
        assert(token.balanceOf(agent) <= 20);
    }
}
