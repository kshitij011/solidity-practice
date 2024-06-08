// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract S {
    string public name;
    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;
    constructor(string memory _text) {
        text = _text;
    }
}

// this contract cannot be called without passing arguments to parent constructor
// for this purpose we call parent constructor from the child to pass the arguments
contract U is
    S("random"),
    T("T text") // this only works when we know the inputs to pass to the constructor
{
    string myName = name;
}

// passing dynamic inputs
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// This is also valid if one value is known
contract VV is S("random"), T {
    constructor(string memory _text) T(_text) {}
}
