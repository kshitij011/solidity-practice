// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// when we use a dynamic data-type we need to declare its data-location
// Data Locations: Storage, Memory, Calldata
contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    // Storage means the variable is a state variable.
    // Anything with storage is stored on blockchain during the execution of contract, hence it uses more gas compared to memory and calldata
    //
    function example() external {
        // Inserting a struct into the mapping
        myStructs[msg.sender] = MyStruct(123, "myText");

        //This variable with storage is stored as the state variable and will persist throughout the contract.
        MyStruct storage my_Struct = myStructs[msg.sender]; // will rreturn the value of sender i.e. a struct.
        my_Struct.text = "myText1"; // this change will be saved even after function execution.

        // memory is used to read the data but it can also be used to update the data.
        MyStruct memory my_Struct2 = myStructs[msg.sender];
        my_Struct2.text = "myText2"; // the updated data will only persist till the function execution.
    }

    // calldata and memory are mostly used in a function which takes input and returns output
    function examples() external pure returns (uint[] memory, MyStruct memory) {
        MyStruct memory my_Struct = MyStruct(456, "someString"); // cannot access the my_Struct set in previous function with storage keyword

        // initialising array in memory. It can only be of fixed size.
        uint[] memory memArr = new uint[](5);
        memArr[0] = 234;
        memArr[2] = 432;

        return (memArr, my_Struct);
    }

    // calldata is like memory and mostly used for function inputs. It uses the least amount of gas.
    // the data-type declared as calldata is non-modifiable. We cannot change the values inside it.
    function example2(uint[] calldata y) public pure {
        _internal(y);
    }

    // the calldata function takes the original input y passed as it is from the example2.
    // the the location was memory then the function _internal would create a duplicate copy of uint[] array.
    // this is how gas is saved by calldata as it does not create duplicate copy of the input.
    function _internal(uint[] calldata _y) private pure {
        uint x = _y[0];
    }
}
