// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// this is a simple app where we can claim ownership of the contract.
// this code is also seen on ethereum mainnet, so this is a practical app.
contract Ownable {
    address public owner; // only the owner will be able to set a new owner

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Enter valid address");
        owner = _newOwner;
    }

    function onlyOwnerCall() external onlyOwner {
        // code
    }

    function anyoneCall() external {
        // code
    }
}
