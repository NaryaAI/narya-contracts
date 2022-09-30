// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./VmEx.sol";

abstract contract ScriptEx {
    address constant private VM_ADDRESS =
    address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));

    VmEx public constant vm = VmEx(VM_ADDRESS);

    // for mapping(uint256 => xx), get slot index of value by map variable name
    function mapKeyUint256SlotByName(address who, string memory mapName, uint256 key) internal view returns (uint256) {
        uint256 mapSlot = vm.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(uint256 => xx), get slot index of value by map variable slot index
    function mapKeyUint256SlotBySlot(address who, uint256 mapSlot, uint256 key) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(address => xx), get slot index of value by map variable name
    function mapKeyAddressSlotByName(address who, string memory mapName, address key) internal view returns (uint256) {
        uint256 mapSlot = vm.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encode(key, mapSlot)));
    }

    // for mapping(addresss => xx), get slot index of value by map variable slot index
    function mapKeyAddressSlotBySlot(address who, uint256 mapSlot, address key) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }
}
