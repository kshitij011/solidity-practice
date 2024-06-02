// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Fallback function is called when a function that you call does not exist inside the contract.
// the main funciton of the callback is to directly send the ether.

contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    fallback() external payable {
        emit Log("Inside fallback", msg.sender, msg.value, msg.data);
    }

    // receive function is executed if the msg.data is empty.
    // If receive function is not declared the fallback function executes even if data field is empty.
    receive() external payable {
        emit Log("Inside receive", msg.sender, msg.value, ""); //  msg.data cannot be used inside receive() as it only executes if the data is missing
    }

    // Note: Pass the value of eth to be sent after deploying the contract.
    // Interact using 'Low Level Interactions' click Transact to execute the function.
    // Low Level Interactions only accept hexa-decimal values.
}
