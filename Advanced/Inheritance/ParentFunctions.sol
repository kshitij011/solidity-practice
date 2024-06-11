// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*Calling parent functions
-direct
-super

    E
   / \
  F   G
   \ /
    H
*/

contract E {
    event Log(string Message);

    // internal functions can called only from inside the contract and child contracts.
    function foo() internal virtual {
        emit Log("E.foo");
    }

    function bar() internal virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() internal virtual override {
        emit Log("F.foo");

        //calling parent function foo directly
        E.foo();
    }

    function bar() internal virtual override {
        emit Log("F.bar");

        //calling function bar using super which calls the parent function
        super.bar();
    }
}

contract G is E {
    function foo() internal virtual override {
        emit Log("G.foo");

        //calling parent function foo directly
        E.foo();
    }

    function bar() internal virtual override {
        emit Log("G.bar");

        //calling function bar using super which calls the parent function
        super.bar();
    }
}

contract H is F, G {
    // when we call a parent function directly, it only calls that function
    function foo() internal override(F, G) {
        F.foo();
    }

    // when we call use super, it calls all the parents once from which the function was inherited.
    // calls contract F, G which will call contract E
    function bar() internal override(F, G) {
        super.bar();
    }
}
