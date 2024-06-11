// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract A {
    function foo() external pure virtual returns (string memory) {
        return "foo";
    }

    function bez() external pure virtual returns (string memory) {
        return "bez";
    }

    function zap() external pure virtual returns (string memory) {
        return "zap";
    }
}

contract B is A {
    function foo() external pure virtual override returns (string memory) {
        return "foo in contract B";
    }
}

//  this contract inherits both contracts A and B, and both have common function foo
//  to prevent conflict between A and B for common function we have to override it.
contract C is A, B {
    //  we need to pass the parameter of contracts thich this function is present in.
    function foo()
        external
        pure
        virtual
        override(A, B)
        returns (string memory)
    {
        return "foo in contract C";
    }
}

contract Test {
    function test() external returns (string memory) {
        C c = new C();
        return c.foo();
    }
}
