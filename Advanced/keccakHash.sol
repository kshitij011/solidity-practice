// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// keccak is a cryptographic function used wildly in solidity.

contract Hash {
    // keccak256 returns a 32 bytes hash in hexa-decimal format.
    function hash(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes32) {
        // keccak256 returns in bytes so the input should also be given in bytes in not, it should be converted to bytes using abi.encode or abo.encodePacked
        return keccak256(abi.encodePacked(text, num, addr));
    }

    // abi.encode and abi.encodePacked both returns 32 bytes hash
    // abi.encodePacked compresses the output, so the output will be smaller and it reduces some of the information from abi.encode.
    // e.g:
    // here the keccak algo isn't used to understand the diff. of encode and encode packed
    // abi.encode and abi.encodePacked both returns data in form of bytes which are dynamic, depends on input size, hence bytes memory is returned.
    function encode(
        string memory text1,
        string memory text2
    ) external pure returns (bytes memory) {
        return abi.encode(text1, text2); // just encodes data into bytes
    }

    // here if the combined string of text1 and text2 is same, then the output encode will be same even if inputs are changed such that the combined string is unchanged.
    // "AAA", "BBB" and "AA", "ABBB" will give same output.
    function encodePacked(
        string memory text1,
        string memory text2
    ) external pure returns (bytes memory) {
        return abi.encodePacked(text1, text2); // compresses the encoded data
    }

    function collision(
        string memory text1,
        string memory text2
    ) external pure returns (bytes32) {
        // Here "AAA", "BBB" and "AA", "ABBB" will give same output.
        // to avoide this collision we can change abi.encodePacked to abi.encode or take in third dynamic input, a uint between two strings.
        // collision(string memory text1, uint x, string memory text2);
        return keccak256(abi.encodePacked(text1, text2));
    }
}
