// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// constructors are special functions that are only called once when the contract is deployed.
contract Constructors {
    address public owner;
    uint public x;

    constructor(uint _x) {
        owner = msg.sender;
        x = _x;
    }
}
