//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import { Resource } from "./Resource.sol"; 

import "hardhat/console.sol";


/**
 * @dev - 
 * @dev - On the assumption that, each resource has resource ID and own contract address.
 */ 
contract ResourceFactory {

    uint currentResourceId;  //@dev - Count of resource ID is started from 0

    address[] public resourceAddresses; //@dev - Every resource's addresses created

    constructor() {}

    function createNewResource() public returns (bool) {
        Resource resource = new Resource();
        resourceAddresses.push(address(resource));
        currentResourceId++;
    }

    //-----------------
    // Getter methods
    //-----------------

    /**
     * @dev - A resource is identified by a resourceId (uint256)
     * @return resourceAddress - Resource's contract address that is associated with resource ID specified
     */ 
    function getResource(uint resourceId) public returns (address resourceAddress) {
        return resourceAddresses[resourceId];
    }

}
