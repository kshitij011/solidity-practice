// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract constants {
    //a const is a variable whose value cannot be changed once declared. E.g:
    // A constant is named with all capitol letters

    //Declaring variables as constant saves gas.

    string public constant MY_NAME = "Raw";

    // function setmyName() public {
    //     myname = 'sae';
    // }    cannot assign another value to a constant variable.
}
