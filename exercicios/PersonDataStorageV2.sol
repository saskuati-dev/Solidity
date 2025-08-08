// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract PersonDataStoragev2{
    string public name;
    uint private  age;
    string internal city;

    constructor(){
        name = "Jao";
        age = 23;
        city = "Ponta Grossa";
    }

    function  setName(string memory _name) public {
        name = _name;
    }

    function getAge()public view returns(uint){
        return age;
    }
}