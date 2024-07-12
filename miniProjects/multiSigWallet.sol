// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// A multisig wallet (also known as multisignature wallet or shared wallet) is a cryptocurrency wallet that requires two or more signatures to confirm and send a transaction
// Basic multiSig wallet

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount); // when a user deposits ETH
    event Submit(uint indexed txId); // when transaction is submitted for approval, it is the index of stored transaction in array
    event Approve(address indexed owner, uint indexed txId); // wallet owners approve the transaction
    event Revoke(address indexed owner, uint indexed txId); // wallet owners can reject the transaction.
    event Execute(uint indexed txId); // Logged when transaction is executed.

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "Approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "");
        _;
    }

    address[] public owners; // array of owners of this wallet
    mapping(address => bool) public isOwner; // check if an address is owner of the wallet
    uint private immutable required;

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public approved; //mapping of the transaction Id approved/revoked by an owner(address)

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required.");
        require(
            _required > 0 && required <= _owners.length,
            "Invalid required number of owners."
        );

        for (uint i = 0; i < _owners.length; i++) {
            require(_owners[i] != address(0), "invalid owner address");
            require(!isOwner[_owners[i]], "address already present");
            owners.push(_owners[i]);
            isOwner[_owners[i]] = true;
        }

        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submit(
        address _to,
        uint _value,
        bytes calldata _data
    ) external onlyOwner {
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );
        emit Submit(transactions.length - 1);
    }

    function approve(
        uint _txId
    ) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for (uint i; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count++;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovalCount(_txId) >= required, "approval < required");
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;

        (bool sucess, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(sucess, "tx failed");

        emit Execute(_txId);
    }

    function revoke(
        uint _txId
    ) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
