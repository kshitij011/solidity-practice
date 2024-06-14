// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
/*
The process of verifying a signature is in four steps:

1. get the message to sign
2. hash(message)
3. sign(hash(message), private_key) sign the message; this will be done offchain using our wallet.
4. ecrecover(hash(message), signature) == signer; verifying the signature inside smart-contract by ecrecover function
*/

contract VerifySig {
    // this function returns if the signer is the sender of the message. args: _signer of the message, the message and the _sig, signature of the message.
    function verify(
        address _signer,
        string memory _msg,
        bytes memory _sig
    ) external pure returns (bool) {
        bytes32 msgHash = hash(_msg);

        // the message signed off-chain is also bytes32. On offchain only message is signed not the hash of the message. So we will pass hashed message to the sign function
        // this function signs the hashed message off-chain.
        bytes32 signedMsgHash = getSignedMsgHash(msgHash);

        // verify hash of signed message i.e signedMsgHash with the signature, this will recover and return the signer which can be compared with the arg _signer to verify if the _signer is the sender of the msg.
        return recover(signedMsgHash, _sig) == _signer;
    }

    function hash(string memory _msg) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_msg));
    }

    function getSignedMsgHash(bytes32 _msgHash) public pure returns (bytes32) {
        // here the hashed messge will be prefixed with some strings and then hashed again involving the private key. This will return signed hashed message i.e: signedMsgHash
        // the message is padded with length of the string
        // e.g: is input is "Ethereum Signed Message:"
        // o/p: "\x19Ethereum Signed Message:\n32"
        return
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _msgHash)
            );
    }

    function recover(
        bytes32 signedMsgHash,
        bytes memory _sig
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig); // uint8 (8 bits = 1 byte) is of length 1 + bytes32 + bytes32 = 65
        // returns the address of the signer
        return ecrecover(signedMsgHash, v, r, s);
    }

    function _split(
        bytes memory _sig
    ) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "Invalid signature length");

        assembly {
            // skips the first 32 bytes from the _sig as it holds the length of _sig.
            r := mload(add(_sig, 32))
            //skips the first 32(length) and second 32(value of r)
            s := mload(add(_sig, 64))
            // getting first byte after 96 bytes
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
