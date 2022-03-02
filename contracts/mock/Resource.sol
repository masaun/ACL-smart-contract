//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import { AccessControlList } from "../AccessControlList.sol";

import "hardhat/console.sol";

contract Resource is AccessControlList {

    //@dev - Metadata that are accociated with the Resource contract
    struct ResourceMetadata {
        string resourceName;
        string resourceURI;   // e.g). Content ID of resource that is stored in IPFS
    }
    mapping (address => ResourceMetadata) resourceMetadatas;  // [Key]: Resource contract address -> the ResourceMetadata struct

    /**
     * @dev - Constructor
     */ 
    constructor(string memory _resourceName, string memory _resourceURI) {
        ResourceMetadata storage resourceMetadata = resourceMetadatas[address(this)];
        resourceMetadata.resourceName = _resourceName;
        resourceMetadata.resourceURI = _resourceURI;
    }

    /**
     * @dev - Edit a resource's metadata
     * @notice - Only group member who has an admin role can call this method.
     */
    function editResourceMetadata(string memory newResourceName, string memory newResourceURI) public onlyAdminRole(msg.sender) returns (bool) {
        // [TODO]: Edit method
    }

    /**
     * @dev - Get a resource's metadata
     * @notice - Only group member (who has an admin or member role) can call this method.
     */ 
    function getResourceMetadata() public onlyMemberRole(msg.sender) returns (ResourceMetadata memory _resourceMetadata) {
        return resourceMetadatas[address(this)];
    }

}
