// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./Vm.sol";

interface VmEx is Vm {

    function readInt(address target, string calldata varName) external view returns (int256);
    function readIntBySlot(address target, uint256 index) external view returns (int256);
    function readInt8(address target, string calldata varName) external view returns (int8);
    function readInt8BySlot(address target, uint256 index, uint256 offset) external view returns (int8);
    function readUint(address target, string calldata varName) external view returns (uint256);
    function readUintBySlot(address target, uint256 index) external view returns (uint256);
    function readUint8(address target, string calldata varName) external view returns (uint8);
    function readUint8BySlot(address target, uint256 index, uint256 offset) external view returns (uint8);

    function readRawBytes(address target, uint256 slot, uint256 offset, uint256 size) external view returns (bytes memory);
    function readBytes(address target, string calldata varName, uint256 size) external view returns (bytes memory);

    function readInt8Array(address target, string calldata varName) external view returns (int8[] memory);
    function readInt8ArrayElem(address target, string calldata varName, uint256 index) external view returns (int8);
    function readInt256Array(address target, string calldata varName) external view returns (int256[] memory);
    function readInt256ArrayElem(address target, string calldata varName, uint256 index) external view returns (int256);
    function readUint8Array(address target, string calldata varName) external view returns (uint8[] memory);
    function readUint8ArrayElem(address target, string calldata varName, uint256 index) external view returns (uint8);
    function readUint256Array(address target, string calldata varName) external view returns (uint256[] memory);
    function readUint256ArrayElem(address target, string calldata varName, uint256 index) external view returns (uint256);

    function readAddressUint256MapValue(address target, string calldata varName, address key) external view returns (uint256);
    function readUint256Uint256MapValue(address target, string calldata varName, uint256 key) external view returns (uint256);

    function getArraySlotIndex(address target, string calldata varName, uint256 index) external view returns (uint256);

    function getVarSlotIndex(address target, string calldata varName) external view returns (uint256);
}

abstract contract ScriptEx {
    address constant private VMEX_ADDRESS =
        address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));

    VmEx private constant vmex = VmEx(VMEX_ADDRESS);

    // for mapping(uint256 => xx), get slot index of value 
    function mapKeyUint256SlotByName(address who, string memory mapName, uint256 key) internal view returns (uint256) {
        uint256 mapSlot = vmex.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encodePacked(key, mapSlot)));
    }

    // for mapping(address => xx), get slot index of value 
    function mapKeyAddressSlotByName(address who, string memory mapName, address key) internal view returns (uint256) {
        uint256 mapSlot = vmex.getVarSlotIndex(who, mapName);
        return uint256(keccak256(abi.encode(key, mapSlot)));
    }
}