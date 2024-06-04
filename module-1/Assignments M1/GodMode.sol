// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract GodMode is ERC20("GodMode", "GM") {
    address public immutable owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    function _mintToAddress(address receipient, uint amount) public onlyOwner {
        //  The _update function burns the amount from total supply and adds the same amount at the receipient balance if the from parameter is address(0).
        _update(address(0), receipient, amount);
    }

    function changeBalanceAtAddress(
        address target,
        uint amount
    ) public onlyOwner {
        uint currentBal = balanceOf(target);
        // uint y;

        //  Here the value currentBal - amount (let's say y) is passed in as a value 'value' which will be removed from _totalSupply and added to from address such that the value passed(y) is the value.
        if (currentBal > amount) {
            // y= currentBal - amount;
            _update(target, address(0), currentBal - amount);
        }

        //  Here the value amount - currentBal (let's say y) is passed in as a value 'value' which will be added to _totalSupply and removed from from address such that the value passed(y) is the value.
        if (currentBal < amount) {
            _update(address(0), target, amount - currentBal);
        }
    }

    function authorativeTransferFrom(
        address from,
        address to,
        uint amount
    ) public onlyOwner {
        _update(from, to, amount);
    }
}
