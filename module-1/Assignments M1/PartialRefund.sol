// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./TokenSale.sol"; // importing in VS code.

// 1000000000000000000 wei = 1000000000000000000000 tokens

contract PartialRefund is TokenSale {
    function sellBack(uint tokenAmount) external {
        // 2000 because partial amount has to be transfered i.e minimum 1 wei.
        require(tokenAmount >= 2000, "value of tokens less than 1 wei");
        _update(msg.sender, address(0), tokenAmount);
        refund(tokenAmount);
    }

    function refund(uint tokenAmount) private {
        //Here amount refunded is half and minimum value of tokens should be 2 wei i.e 2000
        uint refundAmount = tokenAmount / 2000;
        payable(msg.sender).transfer(refundAmount);
    }
}
