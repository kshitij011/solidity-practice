// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract A {
    //  virtual represants that the function can be modified by the child.
    function foo() external pure virtual returns (string memory) {
        return "A";
    }

    function ber() external pure virtual returns (string memory) {
        return "B";
    }

    function zap() external pure returns (string memory) {
        return "Z";
    }
}

contract B is A {
    // overrides represents that the inherited function can be modified.
    function foo() external pure override returns (string memory) {
        return "A in B contract";
    }

    // virtual and override together represent that the inherited function has been modified.
    // And the function can be modified in other contracts whichever inherits this contract.
    function ber() external pure virtual override returns (string memory) {
        return "B in B contract";
    }
}

contract C is B {
    function ber() external pure override returns (string memory) {
        return "B in C contract";
    }
}
