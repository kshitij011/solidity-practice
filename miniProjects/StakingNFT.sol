// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Item is ERC721 {
    address public game;
    constructor() ERC721("Item", "IT") {
        _mint(msg.sender, 10);
    }
}

contract Game is IERC721Receiver {
    IERC721 public itemNFT; // https://ethereum.stackexchange.com/questions/132964/a-few-simple-question-about-using-interfaces-vs-standard-contracts-ierc721-vs

    mapping(uint => address) public originalOwner;

    constructor(IERC721 _address) {
        itemNFT = _address;
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        originalOwner[tokenId] = from;
        return IERC721Receiver.onERC721Received.selector;
    }

    function depositNFT(uint tokenId) external {
        originalOwner[tokenId] = msg.sender;
        itemNFT.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    // function to withdraw back the NFT to owner
    function withdrawNFT(uint tokenId) external {
        // anyone can call this function and steal tokens, to avoid this we keep track of who deposited  that token.
        require(originalOwner[tokenId] == msg.sender, "Not original owner.");
        itemNFT.safeTransferFrom(address(this), msg.sender, tokenId);
    }
}

//Gemini:

// Calling Interface Functions:

//     When you call itemNFT.safeTransferFrom in the Game contract, Solidity performs these steps:
//         It recognizes that itemNFT is an interface variable.
//         It checks if the contract referenced by itemNFT (which is likely Item in your scenario) inherits from an interface that defines safeTransferFrom.
//         If inheritance exists (Item inherits from ERC721), Solidity looks for the implementation of safeTransferFrom in the inherited contract (ERC721).
//         It then executes the actual code defined in ERC721 for safeTransferFrom, handling the token transfer logic.

//GPT:

// Inheritance vs. Interface:

//     The Item contract inherits from ERC721, meaning it is an ERC721 token with all its functionalities.
//     The Game contract uses IERC721, which is an interface, to interact with any ERC721 token.

// Interoperability:

//     The Game contract can interact with any ERC721 token because it uses the IERC721 interface. This makes it flexible and reusable for different ERC721 tokens.

// Decoupling:

//     By using IERC721, the Game contract doesn't need to implement or inherit the entire ERC721 logic. It only needs to know how to call the standard functions defined in the IERC721 interface.
