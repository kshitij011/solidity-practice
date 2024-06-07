// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Calling other contract functions using call
contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called.");
    }

    receive() external payable {
        emit Log("fallback was called.");
    }

    function foo(
        string memory _message,
        uint _x
    ) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

// abi.encodWithSignature();
// Syntax: bytes memory encodedData = abi.encodeWithSignature(signatureString, arg);
// In string signature if other contract is called which takes argument, the function name with argument type is written without any space.
// uint is written as uint256.

// eg: function callSetValue(address targetAddress, uint256 _value) public {
//         bytes memory data = abi.encodeWithSignature("setValue(uint256)", _value);

//         // Perform the low-level call
//         (bool success, ) = targetAddress.call(data);
//         require(success, "Call failed");
//     }

contract Call {
    bytes public data;
    // passing address of another contract
    // This is the Low Level Function for calling the function from other contract
    function callFoo(address _test) external payable {
        // abi.encodeWithSignature is a function used to encode function calls, which are understood by EVM.
        // this encoding is useful for interacting with other contracts or when we need to prepare data for Low Level Calls.(call, delegatecall or staticcall)
        // we can also pass some ether value to the contract function, if the function is payable.

        (bool success, bytes memory _data) = _test.call{value: 111}(
            abi.encodeWithSignature("foo(string,uint256)", "foo called", 123)
        );
        require(success, "Call failed");
        data = _data;
    }

    function callDoesNotExist(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111}(
            abi.encodeWithSignature("foo(string,uint256)", "foo called", 123)
        );
        require(success, "Call failed");
        data = _data;
    }
}
