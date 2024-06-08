// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Immutable are like constant once the value is set, it cannot be changed later on.
// we can initialise it only once when the contract is deployed.

contract Immutable {
    // value can be assigned at deployment time(in the constructor, useful to take input)
    // values can be set during deployment
    // immutable saves much more gas.
    // Stored in storage, but optimised and cheaper to access than regular storage variables.
    address public immutable owner;

    // value has to be assigned at compile time
    // constant does not occupy storage slot, stored in bytecode.
    uint public constant x = 1;

    constructor(address _myAdd) {
        owner = _myAdd;
    }

    function foo() external view {
        require(msg.sender == owner);
        // x += 1; cannot be done on constant
    }
}
