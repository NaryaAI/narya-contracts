// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Script.sol";
import "./VmEx.sol";

abstract contract ScriptEx is Script {
    address constant private VM_EX_ADDRESS =
    address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));

    VmEx public constant vmEx = VmEx(VM_EX_ADDRESS);

    // Sets the *next* call's msg.sender to be the input address
    function asAccountForNextCall(address addr) public {
        vm.prank(addr);
    }
    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function asAccountForNextCall(address addr, address origin) public {
        vm.prank(addr, origin);
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function asAccountBegin(address addr) public {
        vm.startPrank(addr);
    }
    function asAccountBegin(address addr, address origin) public {
        vm.startPrank(addr, origin);
    }
    // Resets subsequent calls' msg.sender to be `address(this)`
    function asAccountEnd() public {
        vm.stopPrank();
    }

    // Change balance of the given address
    function setNativeBalance(address account, uint256 amount) public {
        vm.deal(account, amount);
    }

    // for mapping(uint256 => xx), get slot index of value by map variable name
    function mapKeyUint256SlotByName(address who, string memory mapName, uint256 key) internal view returns (uint256) {
        uint256 mapSlot = vmEx.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(uint256 => xx), get slot index of value by map variable slot index
    function mapKeyUint256SlotBySlot(address who, uint256 mapSlot, uint256 key) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(address => xx), get slot index of value by map variable name
    function mapKeyAddressSlotByName(address who, string memory mapName, address key) internal view returns (uint256) {
        uint256 mapSlot = vmEx.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encode(key, mapSlot)));
    }

    // for mapping(addresss => xx), get slot index of value by map variable slot index
    function mapKeyAddressSlotBySlot(address who, uint256 mapSlot, address key) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }
}
