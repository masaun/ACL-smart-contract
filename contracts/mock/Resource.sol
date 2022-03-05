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
    mapping (address => ResourceMetadata) resourceMetadatas;  // [Key]: This Resource contract address -> the ResourceMetadata struct

    /**
     * @dev - Constructor
     * @notice - Only group member who has an admin role can call this method.
     */ 
    constructor() {}

    /**
     * @dev - Create a new resource's metadata
     * @notice - Only group member who has an admin role can call this method.
     */ 
    function createNewResourceMetadata(
        string memory _resourceName, 
        string memory _resourceURI
    ) public onlyAdminRole(msg.sender) returns (bool) {
        ResourceMetadata storage resourceMetadata = resourceMetadatas[address(this)];
        resourceMetadata.resourceName = _resourceName;
        resourceMetadata.resourceURI = _resourceURI;
    }

    /**
     * @dev - Edit a resource's metadata
     * @notice - Only group member who has an admin role can call this method.
     */
    function editResourceMetadata(
        string memory newResourceName, 
        string memory newResourceURI
    ) public onlyAdminRole(msg.sender) returns (bool) {
        address adminRoleUser = msg.sender;

        ResourceMetadata storage resourceMetadata = resourceMetadatas[address(this)];
        if (keccak256(abi.encodePacked(newResourceName)) != keccak256(abi.encodePacked(""))) {
            resourceMetadata.resourceName = newResourceName;
        }
        if (keccak256(abi.encodePacked(newResourceURI)) != keccak256(abi.encodePacked(""))) {
            resourceMetadata.resourceURI = newResourceURI;
        }
    }

    /**
     * @dev - Get a resource's metadata
     * @notice - Only group member (who has an admin role or a member role) can call this method.
     */
    function getResourceMetadata() public view onlyAdminOrMemberRole(msg.sender) returns (ResourceMetadata memory _resourceMetadata) {
        return resourceMetadatas[address(this)];
    }

}
