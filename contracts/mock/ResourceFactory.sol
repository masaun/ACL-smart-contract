//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import { Resource } from "./Resource.sol"; 

import "hardhat/console.sol";

contract ResourceFactory {

    uint currentResourceId;  //@dev - Count of resource ID is started from 0

    address[] public resourceAddresses; //@dev - Every resource's addresses created

    constructor() {}

    function createNewResource() public returns (bool) {
        Resource resource = new Resource();
        resourceAddresses.push(address(resource));
        currentResourceId++;
    }

}
