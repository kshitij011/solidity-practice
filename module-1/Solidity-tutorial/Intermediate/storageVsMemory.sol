// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// storage consumes more gas. The storage is persistant throughout the contract.
// using storage the original data is passed in function.
// If the state variable is changed in the function using the storage, the original data is modified.
// Whereas in memory the copy of the data is created and that copy only lasts till the function execution.

contract Storage {
    string[] public student = ["Ravi", "Rita", "Aman"];

    function mem() public view {
        // The copy of student array is stored in s1.
        // Any modification done will be executed applied on s1 and not students array.
        // This s1 will last till the end of function execution.
        string[] memory s1 = student;
        s1[0] = "Akash";
    }

    function sto() public {
        // Here the function visibility is not view because the student array which is outside the scope is modified
        // The s1 pooints to the original students array and does not create its copy.
        // Any mosification done to s1 function will reflect in original student array.
        // s1 will last till function execution execution but changes made are saved to original data.
        string[] storage s1 = student;
        s1[0] = "Akash";
    }
}
