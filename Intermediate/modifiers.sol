// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// allows us to reuse the code
// modifier can be implemented on a function by palcing the name of modifier in the function signature.
contract Modifier {
    bool public paused;
    uint public count;

    modifier whenNotPaused() {
        require(!paused, "paused");
        _; //the underscore tells the solidity to continue execute the function that this modifier wraps.
    }

    function setPause(bool _paused) external {
        paused = _paused;
    }

    function inc() external whenNotPaused {
        // require(!paused, 'pausued');
        count += 1;
    }

    function dec() external whenNotPaused {
        // require(!paused, 'pausued');
        count -= 1;
    }

    // modifiers using inputs:

    modifier cap(uint _x) {
        require(_x < 100, "x is greater than 99");
        _; //this will execute the incBy() function completely
    }
    function incBy(uint _x) external whenNotPaused cap(_x) {
        // require(_x<100, 'x is greater than 99');
        count += _x;
    }

    // function modifiers with sandwitched code:
    modifier sandwitch() {
        //code
        count += 10;
        _; //the further code will be executed after the foo() function has bee executed completely
        //more code
        count *= 2;
    }

    function foo() external sandwitch {
        count += 1;
    }
}
