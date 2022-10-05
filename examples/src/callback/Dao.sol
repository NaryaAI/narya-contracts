// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAO {
    mapping(address => uint256) public balances;

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function deposit(address _to) public payable {
        balances[_to] = balances[_to] + msg.value;
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }

            unchecked {
                balances[msg.sender] -= _amount;
            }
        }
    }
}
