//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import { AccessControlList } from "../AccessControlList.sol";

import "hardhat/console.sol";

contract Resource is AccessControlList {

    //@dev - Metadata that are accociated with the Resource contract
    struct ResourceMetadata {
        string resourceName;
        uint resourceAmount;
    }
    mapping (address => ResourceMetadata) resourceMetadatas;  // [Key]: Resource contract address -> the ResourceMetadata struct

    constructor() {}

    /**
     * @dev - Get a ResourceMetadata struct that are accociated with the Resource contract
     */ 
    function getResourceMetadata() public returns (ResourceMetadata memory _resourceMetadata) {
        return resourceMetadatas[address(this)];
    }

}
