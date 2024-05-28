// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// mappings cannot be iterated and aslo cannot get the size of the mapping.
// this code shows how can mappings be created such that they are iterable and return the size.

contract IterableMapping {
    // this is the mapping which stores the balances of the address
    mapping(address => uint) public balances;

    //this mapping checks if a key is inserted in a balances mapping, returns true if it exists
    mapping(address => bool) public inserted;

    // to keep track of the keys that we inserted into the array we need an array
    address[] public addresses;

    // this function sets the balance of the mapping balances
    function set(address _key, uint _balance) external {
        //insert new address or update balance of that address in the balances mapping.
        balances[_key] = _balance;

        //checks if key inserted is newly inserted address or not.
        //If the key is newly inserted, the key is pushed in the array.
        // By storing the unique keys in addresses array we can find the length and get the elements from the array.
        if (!inserted[_key]) {
            inserted[_key] = true;
            addresses.push(_key);
        }
    }

    // getting the length of the addresses array
    function getSize() external view returns (uint) {
        return addresses.length;
    }

    //getting the first element from the array
    function first() public view returns (address) {
        return addresses[0];
    }

    //getting the balance
    function firstBal() external view returns (uint) {
        // we will get the first address from the addresses arrary which will return the first address.
        // then we will search that address in the balances mappings and return the balance associated with that address.
        return balances[addresses[0]];
    }
}
