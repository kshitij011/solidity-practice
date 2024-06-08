// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract TokenSale is ERC20("Token Sale", "TS") {
    address private immutable owner;
    constructor() {
        owner = msg.sender;
    }
    uint private amount;

    // uint public tokensToMint;

    receive() external payable {
        amount = msg.value;
        _mintTokensToAddress();
    }

    function _mintTokensToAddress() internal {
        require(
            totalSupply() <= 1000000 * (1 * 10 ** 18),
            "Total supply reached. Sale Closed"
        );
        // tokensToMint = amount * 1000;
        _update(address(0), msg.sender, amount * 1000);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not Owner");
        payable(owner).transfer(address(this).balance);
    }
}
