// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OpenZeppelinNFT is ERC721("MyNFT", "MNT"), Ownable(msg.sender) {
    // in ownable contract there is no immutable owner, so the owner can revoke or transfer ownership, in that case there will be no fixed owner to transfer amount to.
    // so create a variable deployer who deployes the contract and is immutable.
    address public immutable deployer;

    constructor() {
        deployer = msg.sender;
    }

    uint public totalSupply = 0;
    uint public constant MAX_SUPPLY = 5;
    uint public constant PRICE = 0.001 ether;

    function mint() external payable {
        require(totalSupply < MAX_SUPPLY, "Total supply used up");
        require(msg.value >= PRICE, "wrong price");
        _mint(msg.sender, totalSupply);
        totalSupply++;
    }

    // this function will create a problem if owner renounces itself by mistake, or if the ownership is transferred by mistake.
    // function withdraw() external onlyOwner{
    //     payable(msg.sender).transfer(address(this).balance);
    // }

    function withdraw() external {
        payable(deployer).transfer(address(this).balance);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://Qmcaj75aENCTTgwTas1gxhiLtmSFdU23cGz6N9HLrggiPm/";
    }
}

// check the nft deployed on testnets.opensea.io
// At address: 0x2f370b56a030bc316d7f84f83495e463a93b0A09
