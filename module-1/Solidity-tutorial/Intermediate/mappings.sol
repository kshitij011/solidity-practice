// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Mapping is like a dictionary in python. It contains key value pairs.
contract Mappings {
    // mapping(key_type => value_type) <modifier> <name>
    // key types can be abbress, uint, int, byte, string.

    //this mapping represents the balance of each address.
    mapping(address => uint) public balances;

    // this mapping represents if an address is friend with another address.
    mapping(address => mapping(address => bool)) public isFriend;
    // mapping(address => address) public addressMap;

    mapping(uint => mapping(uint => bool)) public numMap;

    bool public val;

    // set elements in a mapping
    function exapmle() public returns (bool) {
        balances[msg.sender] = 123; //setting values in mapping
        uint bal = balances[msg.sender]; // get the value from mapping

        balances[msg.sender] += 456;

        // setting value of nested mapping
        isFriend[msg.sender][address(this)] = true;

        numMap[1][1] = true;
        val = numMap[1][1];
        return val;
    }
}
