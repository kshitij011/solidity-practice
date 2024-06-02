// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract EthWallet {
    address payable public owner;

    event Log(address from, uint amount);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Log(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(msg.sender == owner, "Not owner");
        require(amount <= address(this).balance, "Insufficient balance");
        //using transfer
        // payable(msg.sender).transfer(amount);

        //using call
        (bool sucess, ) = payable(msg.sender).call{value: amount}("");
        require(sucess, "transaction failed!");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    // // uint bal = address(this).balance; this is a static declaration and not dynamic. Wrong way to do.
    // // Get balance through function as it will be dynamic.

    // //send Eth to a wallet
    // // If the function is only sending Ether and not receiving, payable keyword shouldn't be used.
    // function withdraw(uint amount)external {
    //     require(owner == msg.sender, 'Not owner');
    //     // require(amount<=address(this).balance, "Insufficient balance");
    //     (bool sucess,) = payable(msg.sender).call{value: amount}("");
    //     require(sucess, "transaction failed!");
    // }
}
