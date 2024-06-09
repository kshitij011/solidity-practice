// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

//types of errors: require / revert / assert
// when an error is thrown there will be a gas refund
// all the state updates done are reverted.
// custom errors save gas
contract error {
    function testRequire(uint _i) external pure {
        require(_i <= 10, "i>10"); //this states that if _i<=10 there is no error,but if _i>10, it throws error 'i>10'.
        // the longer the error message the more gas is uesd.
        //code
    }

    //revert function is useful in nested ifelse statements to prevent double checking and save gas.
    function testRevert(uint _i) external pure {
        if (_i <= 10) {
            //code
            if (_i <= 5) {
                //code
                if (_i == 0) {
                    revert("i is empty");
                    //code
                }
            }
        }
    }

    //assert is used to check for a condition that should always be true

    uint public num = 123;

    //this function ensures that value of num should always be equal to 123, if not it will throw an error.
    function testAssert() public view {
        assert(num == 123);
    }
    function incrementNum() public {
        num += 1;
    }

    // custom error: custom errors can only be used with revert.
    error MyError(address caller, uint i, string err);

    function testCustomError(uint _i) public view {
        if (_i > 10) {
            revert MyError(msg.sender, _i, "i is greater than 10");
        }
    }
}
