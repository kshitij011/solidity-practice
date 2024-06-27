// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC1155(""), Ownable(msg.sender) {
    // total supplies of multiple NFT's i.e: token 0 will have 50 total supply
    uint[] supplies = [50, 100, 150];

    // track the number of total tokens minted.
    uint[] minted = [0, 0, 0];

    uint[] rates = [0.05 ether, 0.1 ether, 0.025 ether];

    function setURI(string memory newURI) public onlyOwner {
        _setURI(newURI);
    }

    function mint(uint id, uint amount) public payable {
        // total types of tokens are equal than length of supplies.
        require(id <= supplies.length, "Token doesn't exist");
        require(id > 0, "Token doesn't exist");
        uint index = id - 1;

        // check if amount is full.
        require(minted[index] + amount <= supplies[index], "Out of supply");
        require(msg.value >= amount * rates[index], "Not enough ether sent");
        _mint(msg.sender, id, amount, "");
        minted[index] += amount;
    }

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "Balance is 0");
        payable(msg.sender).transfer(address(this).balance);
    }

    // function mintBatch(address to, uint[] memory ids, uint[] memory values, bytes memory data) public {
    //     _mintBatch(to, ids, values, data);
    // }
}
