// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ifElse {
    function printNum(int _x) external pure returns (string memory) {
        if (_x == 0) {
            return "fail";
        } else if (_x > 0) {
            return "not nothing";
        } else {
            return "Enter valid number";
        }
    }

    function ternary(uint _x) external pure returns (uint) {
        return _x > 5 ? 1 : 0;
    }
}
