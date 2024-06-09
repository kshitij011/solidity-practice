// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Array {
    //dynamic size array
    uint[] public nums = [1, 2, 3];
    //fixed size array
    uint[3] public nums2 = [5, 6, 7];

    function examples() external {
        //pushing into array
        nums.push(4); // [1, 2, 3, 4]
        uint x = nums[1]; // x=2
        nums[2] = 777; // nums[2] = 3 will be replaced by 777 [1, 2, 777, 4]
        delete nums[1]; // [1, 0, 777, 4]
        nums.pop(); // [1, 0, 777]
        uint len = nums.length;

        // creating array in memory
        uint[] memory a = new uint[](5); //5 is the size of the array. Array in memory has to be of fixed size, so push and pop cannot be called.
        //we can only update or get the value form array
        a[1] = 123;
    }

    //arrays can be returned but it is not recommended to return array as it can be of any size.
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}
