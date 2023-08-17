// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
// what happens if someone sends this contract ETH without calling the fund function
// The Eth will just go to the contract for now. 
// receive & callback;

contract fallBackExample {
    uint256 public  result;

    receive() external payable {
        result ++;
    }

    fallback() external payable {
        result = 128;
    }
}