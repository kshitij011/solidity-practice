// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/* 3 ways to send ETH
    .transfer: transfer sends 2300 gas, if the transfer fails the whole function fails.
    .send: It also sends 2300 gas, if transfer fails it returns bool. It is not used in most contracts
    .call: sends all gas, returns bool and some data
*/
contract SendEth {
    // this contract need to be able to receive ehter
    // to make it receivable we can define a payable contract
    constructor() payable {}

    //another way
    fallback() external payable {}
    receive() external payable {}

    //functions to send ETH:

    function sendViaTransfer(address payable _to) external payable {
        //transfer sends 2300 gas to the other contract to receive the transaction.
        //If the gas limit exceeds the gas will be rentured and transfer will fail.
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable returns (bool) {
        // send sends 2300 gas
        // It returns bool if the transaction suceeds or fails.
        bool sent = _to.send(123);
        require(sent, "send failed");
        return sent;
    }

    // recommended way to send ether
    function sendViaCall(address payable _to) external payable {
        // returns a bool and some data of bytes. Data field can be skipped
        // syntax: (bool sucess, bytes memory data) = address.call{value: amountOfEth}("")
        (bool sucess, ) = _to.call{value: 123}("");
        require(sucess, "call failed");
    }
}

contract ReceiveEth {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
