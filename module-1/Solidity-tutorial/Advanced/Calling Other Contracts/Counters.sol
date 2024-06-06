// SPDX-License-Identifier: MIT

// Deploy this contract.
// Pass the address of this contract in the other contract to call functions form this contract.
pragma solidity ^0.8;

contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}
