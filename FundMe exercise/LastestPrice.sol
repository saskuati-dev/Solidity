// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol';

contract LastestPrice{
    AggregatorV3Interface internal priceFeed;
    constructor (address '0x694AA1769357215DE4FAC081bf1f309aDC325306'){
        priceFeed = AggregatorV3Interface(_priceFeed); //0x694AA1769357215DE4FAC081bf1f309aDC325306 
    }

    function getLatestPrice()public  view returns(int256){
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        return price;
    }
}