// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract counter {
    int public count;

    function inc() public {
        count += 1;
    }

    function dec() public {
        count -= 1;
    }
}
