# Narya.ai | Contracts

## Developping
To test and debug `narya-contracts` API:

```
# clone and prepare narya-contracts environment
git clone https://github.com/NaryaAi/narya-contracts.git
cd /path/to/narya-contracts
yarn install
yarn link

# goto target contract root
cd /path/to/target/contract/project/root
yarn link narya-contracts
```

## Cheatcodes Extension

### Basic API
we can read any var value (private | public) via following APIs.

```solidity
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
```

Same with `Vm` in foundry, `VmEx` also locate at `0x7109709ECfa91a80626fF3989D68f67F5b1DD12D`

> `address(bytes20(uint160(uint256(keccak256('hevm cheat code')))))`

### API for mapping

```solidity

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
```

Because there could be multiple definitions of mapping, we only provide basic abilities to get `mapping value slot index`.

Combining with `readIntBySlot | readInt8BySlot | readUintBySlot | readUint8BySlot`, we can get mapping value.

More complicated, `Embedding mapping`, for example:

> Here is a embedding mapping `mapping(uint, mapping(uint, uint)) embed`.
>
> Our target is to read value of `embed[123][address(0x79)]`:

```solidity
// get slot index of internal mapping `mapping(uint, uint)` <=> embed[123]
uint slot1 = mapKeyUint256SlotByName(address(dummy), "embed", 123);
// get slot index of target value <=> embed[123][address(0x79)]
uint slot2 = mapKeyUint256SlotBySlot(address(dummy), slot1, address(0x79));
// get slot value be slot index
uint result = vm.readUintBySlot(address(dummy), slot2)
```

`result` is value of `embed[123][address(0x79)]`.

### Example
Example target contract is:
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Dummy {
    uint8 public val;
    uint256 public val256;
    uint16 public val16;
    uint8[] private array8 = [0, 1, 2];
    mapping(uint256 => uint256) private map256;
    mapping(address => uint256) private mapAddress;

    function f(uint8 _val) public {
        val = _val;
        val256 = uint256(_val);
        val16 = (uint16(_val) << 16) | uint16(_val);
        array8[0] = _val;
        map256[123] = uint256(_val);
        mapAddress[address(0x79)] = uint256(_val);
    }

    function g() public {
        val = 0;
    }
}
```

Our invariant is `mapAddress[address(0x79)] != 23`. we can implement this invariant in `check()` function.

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "contracts/Dummy.sol";
import "narya-contracts/PTest.sol";

contract TestPrivDummy is PTest {
    Dummy dummy;

    function setUp() public {
        dummy = new Dummy();
    }

    function check() external view override {
        //require(dummy.val() != 127, "wrong val");
        //require(vm.readInt8(address(dummy), uint256(keccak256("val"))) != 127, "wrong val");
        //require(vm.readInt(address(dummy), "val256") != 127, "wrong val");
        //require(vm.readInt8ArrayElem(address(dummy), "array8", 0) != 65, "wrong val");
        //require(vm.getVarSlotIndex(address(dummy), "array8") != 3, "wrong val");
        //uint slot = mapKeyUint256SlotByName(address(dummy), "map256", 123);
        uint slot = mapKeyAddressSlotByName(address(dummy), "mapAddress", address(0x79));
        require(vm.readUintBySlot(address(dummy), slot) != 23, "wrong val");
    }
}
```

1. Get `mapAddress[0x79]` value slot index by api `mapKeyAddressSlotByName`, and store return value into `slot`
2. use `vm.readUintBySlot` to read `slot` value as `uint256`.

## Q&A
1. `Evm Revert` error in trace report.

> Possible Solution:
> check target variable type and API usage. var type should be same with API:

| variable type | API for reading variable |
| :- | :- |
| uint / uint256 | readUint / readUint256ArrayElem / readUint256Array |
| int / int256 | readInt / readInt256ArrayElem / readInt256Array |
| uint8 | readUint8 / readUint8ArrayElem / readUint8Array |
| int8 | readInt8 / readInt8ArrayElem / readInt8Array |

## TODO
* [ ] Support more integer types (16 / 32 / 48 / 64, etc.)
* [ ] adapt with a better local testing tool

## Reference
* [solidity interna: layout in storage](https://docs.soliditylang.org/en/v0.8.13/internals/layout_in_storage.html)
