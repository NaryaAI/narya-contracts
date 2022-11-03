// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
pragma experimental ABIEncoderV2;

import "forge-std/Vm.sol";

interface VmEx is Vm {
    // read int256 variable by name
    function readInt(address target, string calldata varName)
        external
        view
        returns (int256);

    // read int256 variable by slot index
    function readIntBySlot(address target, uint256 index)
        external
        view
        returns (int256);

    // read int8 varriable by name
    function readInt8(address target, string calldata varName)
        external
        view
        returns (int8);

    // read int8 variable by slot index and offset
    function readInt8BySlot(
        address target,
        uint256 index,
        uint256 offset
    ) external view returns (int8);

    // read uint256 variable by name
    function readUint(address target, string calldata varName)
        external
        view
        returns (uint256);

    // read uint8 variable by slot index
    function readUintBySlot(address target, uint256 index)
        external
        view
        returns (uint256);

    // read uint8 variable by name
    function readUint8(address target, string calldata varName)
        external
        view
        returns (uint8);

    // read uint8 by slot index and offset
    function readUint8BySlot(
        address target,
        uint256 index,
        uint256 offset
    ) external view returns (uint8);

    // read address variable by name
    function readAddress(address target, string calldata varName)
        external
        view
        returns (address);

    // read address by slot index and offset
    function readAddressBySlot(
        address target,
        uint256 index,
        uint256 offset
    ) external view returns (address);

    // read raw `size` bytes by slot index and slot offset
    function readRawBytes(
        address target,
        uint256 index,
        uint256 offset,
        uint256 size
    ) external view returns (bytes memory);

    // read `size` bytes by variable name
    function readBytes(
        address target,
        string calldata varName,
        uint256 size
    ) external view returns (bytes memory);

    // read whole int8 array data by name
    function readInt8Array(address target, string calldata varName)
        external
        view
        returns (int8[] memory);

    // read int8 array element at index by name
    function readInt8ArrayElem(
        address target,
        string calldata varName,
        uint256 index
    ) external view returns (int8);

    // read whole int256 array data by name
    function readInt256Array(address target, string calldata varName)
        external
        view
        returns (int256[] memory);

    // read int256 array element at index by name
    function readInt256ArrayElem(
        address target,
        string calldata varName,
        uint256 index
    ) external view returns (int256);

    // read whole uint8 array data by name
    function readUint8Array(address target, string calldata varName)
        external
        view
        returns (uint8[] memory);

    // read uint8 array element at index by name
    function readUint8ArrayElem(
        address target,
        string calldata varName,
        uint256 index
    ) external view returns (uint8);

    // read whole uint256 array data by name
    function readUint256Array(address target, string calldata varName)
        external
        view
        returns (uint256[] memory);

    // read uint256 array element at index by name
    function readUint256ArrayElem(
        address target,
        string calldata varName,
        uint256 index
    ) external view returns (uint256);

    function readAddressUint256MapValue(
        address target,
        string calldata varName,
        address key
    ) external view returns (uint256);

    function readUint256Uint256MapValue(
        address target,
        string calldata varName,
        uint256 key
    ) external view returns (uint256);

    // get 1D Array[index] slot id by variable name
    function getArraySlotIndex(
        address target,
        string calldata varName,
        uint256 index
    ) external view returns (uint256);

    // get slot id by variable name
    function getVarSlotIndex(address target, string calldata varName)
        external
        view
        returns (uint256);
}
