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
