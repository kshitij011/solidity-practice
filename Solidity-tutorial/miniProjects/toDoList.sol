// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// read, insert, update from array of structs
contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function insert(string calldata _text) public {
        Todo memory todo = Todo(_text, false);
        todos.push(todo);
    }

    function update(uint index, bool b) public {
        todos[index].completed = b;
    }

    function read(uint index) public view returns (Todo memory) {
        return todos[index];
    }

    function list() public view returns (Todo[] memory) {
        return todos;
    }
}
