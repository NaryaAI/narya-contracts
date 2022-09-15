// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMalware {
    function world() external;
}

contract Target {
    bool public open_door = false;
    bool public stolen = false;

    constructor() {}

    function hello(address mal) public {
        open_door = true;
        IMalware(mal).world();
        open_door = false;
    }

    function backdoor() public {
        require(open_door, "");
        stolen = true;
    }
}
