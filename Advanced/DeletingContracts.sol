// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// the selfdestruct function has been deprocated and does not work with greater solidity compilers.

contract Delete {
    constructor() payable {}
    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function nums() public pure returns (uint) {
        return 123;
    }
}
