// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract test {
    uint public maxUint = type(uint).max; //ranges from 0 to 2**256 -1.  Default value 0. Max length is 78 charactrs long.
    int public maxInt = type(int).min; //ranges from -2**255 to 2**255 -1.  Default value 0. Max and min length is 77 characters long

    address public myAddress = msg.sender; //defaut address 0x00...0000. An address is 42 characters long.
    string public myString; //default value empty string.
    bool public myBoolean; //default value false.
    bytes public myByte; // bytes is a dynamically sized array
}
