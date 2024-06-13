// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// libraries allow us to seperate and reuse code. Also allows us to enhance data-types.

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint x) public view returns (uint) {
        for (uint i = 0; i <= arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }

        revert("not found");
    }
}

contract TestArray {
    // it specifies that for all arrays of data-type uint[], attach all of the functionalities defined inside library.
    using ArrayLib for uint[];
    uint[] public arr = [1, 2, 3];

    function testFind() external view returns (uint i) {
        // return ArrayLib.find(arr, 2);
        //alternative syntax:
        return arr.find(2);
    }
}
