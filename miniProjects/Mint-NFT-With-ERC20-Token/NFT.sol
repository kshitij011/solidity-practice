// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "./Token.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721("MyNFT", "MN") {
    uint public totalSupply;
    // address public tokenAddress;
    MyToken public tokenAddress;
    uint public rate = 10;
    address private owner;

    // address of the ERC20 token
    constructor(address _tokenAddress) {
        tokenAddress = MyToken(_tokenAddress);
        owner = msg.sender;
    }

    function safeMint() public {
        // approve the ERC721 contract to withdraw ERC20 tokens on your befhalf and mint you tokens.
        // transfer tokens from msg.sender to this address.
        // tokenAddress.transferFrom() the ERC20 account address does not have transferFrom method but extends IERC20 interface which can be used to interface with ERC20(Token) contract
        tokenAddress.transferFrom(msg.sender, address(this), rate);
        _safeMint(msg.sender, totalSupply);
        totalSupply++;
    }

    function withdrawToken() external {
        require(msg.sender == owner, "Only owner can withdraw");
        tokenAddress.transfer(
            msg.sender,
            tokenAddress.balanceOf(address(this))
        ); // address(this).balance returns the balance in ETH
    }
}
