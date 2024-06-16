// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/utils/Strings.sol";

contract SimpleNFT {
    using Strings for uint;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
    // mapping of tokenId to owner address of the token.
    // uint is before address because no. of tokens are known but addresses can vary.
    mapping(uint256 => address) private _owners;

    mapping(address => mapping(address => bool)) private _operators;

    mapping(address => uint) private _balances;

    // url of the image
    string baseURI = "https://example.com/images/";

    function mint(uint _tokenId) external {
        require(_owners[_tokenId] == address(0), "Already minted");
        require(_tokenId <= 100, "No tokens left");
        _owners[_tokenId] = msg.sender;

        emit Transfer(address(0), msg.sender, _tokenId);
        _balances[msg.sender] += 1;
    }

    function ownerOf(uint _tokenId) external view returns (address) {
        require(_owners[_tokenId] != address(0), "No such  token.");
        return (_owners[_tokenId]);
    }

    function transferFrom(address _from, address _to, uint _tokenId) external {
        require(_owners[_tokenId] != address(0), "token doesn't exist");
        require(
            _owners[_tokenId] == _from,
            "From address isn't the owner of the token"
        );
        // msg.sender should bw approved from the _from address.
        require(
            _from == msg.sender || _operators[_from][msg.sender],
            "only token owner or approved operator can transfer tokens."
        );

        _owners[_tokenId] = _to;
        _operators[_from][msg.sender] = false; // after transfering token, the operator loses the permission to operate sold token

        emit Transfer(_from, _to, _tokenId);

        _balances[_from] -= 1;
        _balances[_to] += 1;
    }

    function tokenURI(uint _tokenId) external view returns (string memory) {
        require(_owners[_tokenId] != address(0), "No such token");
        return string(abi.encodePacked(baseURI, _tokenId.toString(), ".jpeg"));
    }

    // giving permission to other contract to handle our assets.
    function setApprovalForAll(address _operator, bool _approved) external {
        _operators[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function balanceOf(address _owner) external view returns (uint) {
        // ?? why do we need to check if the address is zero as the function cannot be called without passing an address.
        require(_owner != address(0), "Zero address");
        return _balances[_owner];
    }
}
