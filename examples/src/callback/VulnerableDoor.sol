// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pwnednomore/contracts/forge-std/console.sol";

interface IMalware {
    function hello() external;
}

contract VulnerableDoor {
    bool public is_open = false;
    bool public stolen = false;
    string public color = "white";

    constructor() {}

    function open(address mal) public {
        is_open = true;
        IMalware(mal).hello();
        is_open = false;
        console.log("Prod console log");
    }

    function backdoor() public {
        require(is_open, "");
        stolen = true;
    }

    function paint(string memory new_color) public {
        color = new_color;
    }
}
