// Get Funds From Users
// Withdraw Funds 
// Set a Minimum Funding Value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";
// There are two keywords to make sure your variable can't be changed in solidity
// These keywords are => constant, immutable

error notOwner();
contract FundMe {

    using PriceConverter for uint256;

    // Want to be able to set a mininum fund Amount in USD
    uint public constant minimumUSD = 50 * 1e18;

    // To keep track of the addresses that is sending us money

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    // Make sure only the user can withdraw funds
    // create a owner constructor
    address public immutable owner;
    constructor() {
        owner = msg.sender;
    }


    // To make ETH payable, use the payable Modifier.

    function fund() public payable {
        // 1. How do we send ETH to the contract?
        // To access the Value Attribute Use the global keyword "msg" with "value" => msg.value
        // To set it to a certain value of Ethereum, use the require keyword

        // require(getConversionRate(msg.value) >= minimumUSD, "Didn't Send Enough ETH");
        require(msg.value.getConversionRate() >= minimumUSD, "Not Enough ETH!!") ;
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    

    function withdraw() public onlyOwner{
        for (uint funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Reset The Array
        funders = new address[](0);
        // Withdraw the funds => 3 ways
        // transfer 
        // payable(msg.sender).transfer(address(this).balance);

        // // send 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Transaction Failed");

        // call => lower level command

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }   

    // Create a modifier so as to make only the only of the contract to withdraw;
    // a modifier 
    modifier onlyOwner {
        // require(msg.sender == owner, "Sender is not Owner");

        // Custom Error
        if (msg.sender != owner) {
            revert notOwner();
        }
        _;
    }

    // what happens if someone sends this contract ETH without calling the fund function
    // The Eth will just go to the contract for now. 

    // receive & callback;

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}