// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// struct allow us to group data together
contract Struct {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    // using struct as state variable, Car is now a data-type.
    Car public car;

    // array of cars. Arrays in solidity cannot store values of different data-types.
    Car[] public cars;

    // mapping of owner to his cars
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        //three ways to initialise a struct

        // memory means this variable will only exist till the function execution.
        Car memory toyota = Car("Toyota", 1990, msg.sender);

        // passing custom values
        Car memory lambo = Car({
            year: 1980,
            model: "Lamborghini",
            owner: msg.sender
        });

        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2020, msg.sender));

        // accessing the first element
        // Storage means that we want modify and save the state inside the contract and outside the function scope.
        Car storage _car = cars[0];
        _car.year = 1999;
        delete _car.owner;

        delete cars[1];
    }
}
