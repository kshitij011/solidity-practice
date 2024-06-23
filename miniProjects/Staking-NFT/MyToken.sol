// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNft is ERC721, Ownable {
    uint public totalSupply;
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {}

    function safeMint(address _to) public {
        _safeMint(_to, totalSupply);
        totalSupply++;
    }
}
