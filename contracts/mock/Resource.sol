//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Resource {

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
