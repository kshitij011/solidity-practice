// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract globalVariables {
    function getGlobalVariables()
        public
        view
        returns (address, uint, uint, uint)
    {
        address myAddress = msg.sender;

        uint timeStamp = block.timestamp;

        uint blockNumber = block.number;

        uint chainId = block.chainid;

        return (myAddress, timeStamp, blockNumber, chainId);
    }
}
