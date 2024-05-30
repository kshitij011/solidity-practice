// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract SimpleStorage {
    string public text;

    // passing input: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    // gas used with calldata: 89626 gas;
    // gas used with memory: 90114 gas;
    function setText(string calldata _str) external {
        text = _str;
    }

    function getText() external view returns (string memory) {
        return text;
    }
}
