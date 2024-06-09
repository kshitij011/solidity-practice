// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Events allow us to write data on the blockchain that can be accessed by the external applications such as front-end interface or backend service.
// Main purpose of event is to log when something happnes.
// Storing data via events is cheaper than storing it in contract storage

contract Event {
    // Declaring event: event Name(<Data-type> <name>, <data-type> <name>)
    event Log(string message, uint val);

    function example() external {
        //this is a transactional function and not read-only function because we are storing transactional data on the blockchain, this is why this function is not view or pure function
        emit Log("Event Logged", 123);
    }

    // using indexed we can search and filter the events by the parameter that was indexed.
    //maximum of three parameters can be indexed.
    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
