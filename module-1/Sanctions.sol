// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Sanctions is ERC20("Sanctioned Contracts", "SC") {
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not owner");
        _;
    }

    mapping(address => bool) private blacklist;

    // ?? how to set owner to false permenantly so owner cannot sanction himself.
    // blacklist[owner] public constant = false;

    modifier sanction(address from, address to) {
        // ?? require(blacklist[from] == false && blacklist[to] == false, "Address sanctioned");
        require(!blacklist[from] && !blacklist[to], "Address sanctioned!");
        // if(blacklist[msg.sender] == false && blacklist[to] == false ){
        _;
        // }else{
        //     revert("Address sanctioned");
        // }
    }

    function manageSanction(address _address, bool _bool) external onlyOwner {
        if (owner != _address) {
            blacklist[_address] = _bool;
        } else {
            revert("cannot sanction owner");
        }
    }

    function _mintToAddress(address receipient, uint amount) public onlyOwner {
        //  The _update function burns the amount from total supply and adds the same amount at the receipient balance if the from parameter is address(0).
        _update(address(0), receipient, amount);
    }

    function transfer(
        address to,
        uint256 value
    ) public override sanction(msg.sender, to) returns (bool) {
        // if(blacklist[msg.sender] == false && blacklist[to] == false ){
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
        // }else{
        //     revert("Address sanctioned");
        // }
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override onlyOwner sanction(from, to) returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }
}
