// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20("MyToken", "MT") {
    function mint(uint amount) external {
        _mint(msg.sender, amount);
    }
}
