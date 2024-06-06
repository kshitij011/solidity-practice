// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CallTestContract {
    // calling the other contract by contract address
    // passing parameters address of the contract to call and the value to be passed in the function of other contract.
    function setX(address _test, uint _x) external {
        // other way of passing arg: setX(TestContract _test, uin _x){
        // _test.setX(_x);
        // }
        // TestContract can be set as type as passed as argument
        // calling test contract and passing the address of it
        // then calling the function inside test contract and passing arguments to it.
        TestContract(_test).setX(_x);
    }

    // Another way of returning a uint, declare x in returns and value of x will be returned from the function.
    function getX(TestContract _test) external view returns (uint x) {
        x = _test.getX();
    }

    function setXandReceiveEth(TestContract _test, uint _x) external payable {
        // to send ETH to this function use {value: msg.value}
        _test.setXandReceiveEth{value: msg.value}(_x);
    }

    function getXandValue(
        TestContract _test
    ) external view returns (uint x, uint value) {
        (x, value) = _test.getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    // function that sets the value of x and can also receive ether
    function setXandReceiveEth(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}
