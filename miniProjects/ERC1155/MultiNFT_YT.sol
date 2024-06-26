// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DEMOPOP is ERC1155, ERC1155Burnable, Ownable {
    constructor()
        ERC1155("ipfs://Qmcaj75aENCTTgwTas1gxhiLtmSFdU23cGz6N9HLrggiPm/")
        Ownable(msg.sender)
    {
        _mint(msg.sender, POP, 100, "");
        _mint(msg.sender, LuckyNFT, 1, "");
    }

    // Proof of participation.
    uint public constant POP = 0;
    uint public constant LuckyNFT = 2;

    function uri(uint tokenId) public pure override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "ipfs://Qmcaj75aENCTTgwTas1gxhiLtmSFdU23cGz6N9HLrggiPm/",
                    Strings.toString(tokenId)
                )
            );
    }

    function contractURI() public pure returns (string memory) {
        return "ipfs://Qmcaj75aENCTTgwTas1gxhiLtmSFdU23cGz6N9HLrggiPm/";
    }

    function airdrop(
        uint tokenId,
        address[] memory recipients
    ) external onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            // _safeTransferFrom(from, to, id, value, data);
            _safeTransferFrom(msg.sender, recipients[i], tokenId, 1, "");

            if (
                balanceOf(msg.sender, POP) == 90 &&
                balanceOf(msg.sender, LuckyNFT) == 1
            ) {
                _safeTransferFrom(msg.sender, recipients[i], 2, 1, "");
            }
        }
    }

    // function _beforeTokenTransfer(address operator, address from, address to, uint[] memory ids, uint[] memory amounts, bytes memory data) internal override {
    //     super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    //     require(msg.sender == owner() || to = address(0), "Token cannot be transfered only be burned.");
    // }
}

// images not visible
// 0x0aa8295DBD7a9929B0E70C4F231351b6286A3aD1   => attributes format metadata file ipfs://QmY1k5eigwaKgErqLNNQaEbPUnoczLj17m8AgJ8sr71dmv/

// images visible
// 0x98ef9cf1B61c7B44ffE599E1e4Ca2406B707C2eC   => name/description fromat metadata file ipfs://Qmcaj75aENCTTgwTas1gxhiLtmSFdU23cGz6N9HLrggiPm/
