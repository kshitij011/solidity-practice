// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// enum allows us to express multiple choices
contract Enum {
    enum Status {
        None,
        Pengding,
        Shipped,
        Completed,
        Rejected,
        Cancled
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    // array of orders
    Order[] public orders;

    function get() public view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }
}
