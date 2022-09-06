// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./Vm.sol";

interface VmEx is Vm {

    // read int256 variable by name
    function readInt(address target, string calldata varName) external view returns (int256);
    // read int256 variable by slot index
    function readIntBySlot(address target, uint256 index) external view returns (int256);
    // read int8 varriable by name
    function readInt8(address target, string calldata varName) external view returns (int8);
    // read int8 variable by slot index and offset
    function readInt8BySlot(address target, uint256 index, uint256 offset) external view returns (int8);
    // read uint256 variable by name
    function readUint(address target, string calldata varName) external view returns (uint256);
    // read uint8 variable by slot index
    function readUintBySlot(address target, uint256 index) external view returns (uint256);
    // read uint8 variable by name
    function readUint8(address target, string calldata varName) external view returns (uint8);
    // read uint8 by slot index and offset
    function readUint8BySlot(address target, uint256 index, uint256 offset) external view returns (uint8);

    // read raw `size` bytes by slot index and slot offset
    function readRawBytes(address target, uint256 slot, uint256 offset, uint256 size) external view returns (bytes memory);
    // read `size` bytes by variable name
    function readBytes(address target, string calldata varName, uint256 size) external view returns (bytes memory);

    // read whole int8 array data by name
    function readInt8Array(address target, string calldata varName) external view returns (int8[] memory);
    // read int8 array element at index by name
    function readInt8ArrayElem(address target, string calldata varName, uint256 index) external view returns (int8);
    // read whole int256 array data by name
    function readInt256Array(address target, string calldata varName) external view returns (int256[] memory);
    // read int256 array element at index by name
    function readInt256ArrayElem(address target, string calldata varName, uint256 index) external view returns (int256);
    // read whole uint8 array data by name
    function readUint8Array(address target, string calldata varName) external view returns (uint8[] memory);
    // read uint8 array element at index by name
    function readUint8ArrayElem(address target, string calldata varName, uint256 index) external view returns (uint8);
    // read whole uint256 array data by name
    function readUint256Array(address target, string calldata varName) external view returns (uint256[] memory);
    // read uint256 array element at index by name
    function readUint256ArrayElem(address target, string calldata varName, uint256 index) external view returns (uint256);

    function readAddressUint256MapValue(address target, string calldata varName, address key) external view returns (uint256);
    function readUint256Uint256MapValue(address target, string calldata varName, uint256 key) external view returns (uint256);

    // get 1D Array[index] slot id by variable name
    function getArraySlotIndex(address target, string calldata varName, uint256 index) external view returns (uint256);

    // get slot id by variable name
    function getVarSlotIndex(address target, string calldata varName) external view returns (uint256);
}

abstract contract ScriptEx {
    address constant private VMEX_ADDRESS =
        address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));

    VmEx private constant vmex = VmEx(VMEX_ADDRESS);

    // for mapping(uint256 => xx), get slot index of value by map variable name
    function mapKeyUint256SlotByName(address who, string memory mapName, uint256 key) internal view returns (uint256) {
        uint256 mapSlot = vmex.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(uint256 => xx), get slot index of value by map variable slot index
    function mapKeyUint256SlotBySlot(address who, uint256 mapSlot, uint256 key) internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(address => xx), get slot index of value by map variable name
    function mapKeyAddressSlotByName(address who, string memory mapName, address key) internal view returns (uint256) {
        uint256 mapSlot = vmex.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encode(key, mapSlot)));
    }

    // for mapping(addresss => xx), get slot index of value by map variable slot index
    function mapKeyAddressSlotBySlot(address who, uint256 mapSlot, address key) internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }
}