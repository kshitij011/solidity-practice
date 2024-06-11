// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Delegate call executes code in another contract in the context of the contract that called it.
// i.e the value of variables is not changed when the delegatecall executes a function from another contract. e.g: the value of owner, sender and other data will not change to the values of other contract whose function is called.
contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    // here the order of declaring variables should be preserved in the contract and calling contract.
    // changing the order of vairable declaration in the calling contrat will result unexpected outputs.
    uint public nums;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        // (bool b, bytes memory data) = _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));

        // alternative syntax line
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "Delegatecall failed");
    }
}

// The delegatecall executes the function of other contracts with its own state variables, changes made by function are applied to caller's state variable.

// The call executes the function of other contract whith the state variables of the calling contract. Changes made by the function on to the variables are stored in that contracts state variables.
