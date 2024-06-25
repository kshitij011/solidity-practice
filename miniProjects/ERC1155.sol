// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract GameItem is ERC1155 {
    uint public constant GOLD = 0;
    uint public constant SILVER = 1;
    uint public constant THORS_HAMMER = 2;

    constructor()
        ERC1155("ipfs://QmY1k5eigwaKgErqLNNQaEbPUnoczLj17m8AgJ8sr71dmv")
    {
        _mint(msg.sender, GOLD, 10 ** 18, "");
        _mint(msg.sender, SILVER, 10 ** 9, "");
        _mint(msg.sender, THORS_HAMMER, 1, "");
    }
}
