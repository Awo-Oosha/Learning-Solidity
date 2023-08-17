// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    // To convert ETH to USD
    // We'll Use Oracle and Chainlink

    function getPrice() internal  view returns (uint256){
        // ABI
        // Address => 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();

        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethprice = getPrice();
        uint256 ethAmountInUsd =(ethprice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}