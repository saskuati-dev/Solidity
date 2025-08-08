// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol';

contract FundMe{
    AggregatorV3Interface internal priceFeed;
    address public owner;
    address[] public funders;

    constructor (address _priceFeed){
        priceFeed = AggregatorV3Interface(_priceFeed); //0x694AA1769357215DE4FAC081bf1f309aDC325306 
        owner = msg.sender;
    }

    function getLatestPrice()internal view returns(uint256){
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        return uint256(price);
    }

    function getConvertionRate(uint256 _ethAmount)internal view returns(uint256){
        uint256 priceFund = (_ethAmount * getLatestPrice())/10**8;
        
        return priceFund;
    }


    mapping(address => uint256) public addressToAmoutFunded;

    function fund() public payable {
        uint256 minimunUSD = 2* 10**18;
        require(
            getConvertionRate(msg.value)>minimunUSD,
            "You need to spend more ETH!"
        );

        if(addressToAmoutFunded[msg.sender] == 0){
            funders.push(msg.sender);
        }
        addressToAmoutFunded[msg.sender] += msg.value;
    }

    modifier onlyOwner(){
        require(msg.sender ==owner, "only owner can use this function");
        _;
    }

    function withdraw() public onlyOwner(){
        payable(owner).transfer(address(this).balance);

        funders = new address[](0);
    }

}