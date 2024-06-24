// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Inheriting this allows our contract to receive NFT's, contains onERC20Received function.
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";

contract MyToken is ERC20("MyToken", "MT"), ERC721Holder, Ownable(msg.sender) {
    // stores the address of token Owner:
    mapping(uint => address) public tokenOwnerOf;
    // stores timestamp for a tokenId
    mapping(uint => uint) public tokenStackedAt;

    // gives rate in per sec
    uint public EMISSION_RATE = (50 * 10 ** decimals()) / 1 days;

    IERC721 public nft;
    constructor(address _nft) {
        nft = IERC721(_nft);
    }

    function stake(uint tokenId) external {
        nft.safeTransferFrom(msg.sender, address(this), tokenId);
        tokenOwnerOf[tokenId] = msg.sender;
        tokenStackedAt[tokenId] = block.timestamp;
    }

    function calculateTokens(uint tokenId) public view returns (uint) {
        uint timeElapsed = block.timestamp - tokenStackedAt[tokenId];
        return timeElapsed * EMISSION_RATE;
    }

    function unstack(uint tokenId) external {
        require(tokenOwnerOf[tokenId] == msg.sender, "Not owner");
        nft.safeTransferFrom(address(this), msg.sender, tokenId);
        _mint(msg.sender, calculateTokens(tokenId));

        delete tokenOwnerOf[tokenId];
        delete tokenStackedAt[tokenId];
    }
}
