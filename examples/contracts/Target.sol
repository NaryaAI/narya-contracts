// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMalware {
    function hello() external;
}

contract Target {
    bool public open_door = false;
    bool public stolen = false;
    string public color = "white";

    constructor() {}

    function open(address mal) public {
        open_door = true;
        IMalware(mal).hello();
        open_door = false;
    }

    function backdoor() public {
        require(open_door, "");
        stolen = true;
    }

    function paint(string memory new_color) public {
        color = new_color;
    }
}
