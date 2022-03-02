//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import { Resource } from "./Resource.sol"; 

import "hardhat/console.sol";


/**
 * @dev - 
 * @dev - On the assumption that, each resource has resource ID and own contract address.
 */ 
contract ResourceFactory {

    uint currentResourceId;  //@dev - resource ID is counted from 0

    address[] public resourceAddresses; //@dev - Every resource's addresses created are stored into this array

    /**
     * @dev - Constructor
     */ 
    constructor() {}

    /**
     * @dev - Create a new resource
     */ 
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
    function getResource(uint resourceId) public view returns (address resourceAddress) {
        return resourceAddresses[resourceId];
    }

    function getCurrentResourceId() public view returns (uint _currentResourceId) {
        return currentResourceId;
    }

}
