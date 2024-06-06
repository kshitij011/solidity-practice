// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Interfaces allow you to call the contract(functions) without having it's code.
// Using Interfaces we can call other contracts
// Interfaces are used to enforce a specific contract structure which derives from it.
// It is type of contracts that defines set of function signatures without any implementation.

// calling other contract 'counter' using interface:

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
    // function dec() external;
}

contract CallInterface {
    uint public count;
    function examples(address _counter) external {
        ICounter(_counter).inc();
        // ICounter(_counter). dec;
        count = ICounter(_counter).count();
    }
}
