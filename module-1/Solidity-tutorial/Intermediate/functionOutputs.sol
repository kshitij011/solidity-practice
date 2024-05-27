// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// how to return multiple outputs

contract FunctionOutputs {
    function returnMany() public pure returns (uint, bool, string memory) {
        return (1, false, "text");
    }

    // capturing the output returned from the function (destructuring variables)
    function destructure() public pure returns (uint, bool, string memory) {
        // (, bool b) if we only need second element.
        (uint x, bool b, string memory txt) = returnMany();
        x += 1;
        b = !b;
        return (x, b, txt);
    }
}
