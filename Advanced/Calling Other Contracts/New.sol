// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Deploying a new contract from another contract

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender; // here it will be the address of the contract AccountFactory that will deploy this contract
        owner = _owner; // owner value is the value passed from the contract calling this contract.
    }
}

// contracts calling other contracts are usually named 'Factory'.
contract AccountFactory {
    Account[] public accounts;
    function createAccount(address _owner) external payable {
        // forwarding some ETH to Account contract using value
        Account account = new Account{value: 111}(_owner); // passing argument to constructor of New contract
        accounts.push(account);
    }

    // After this contract has been deployed, we will get the deployed address contract from the array.
}
