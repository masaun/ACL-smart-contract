//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentGroupId;

    struct AdminGroup {
        uint groupId;
    }
    mapping (uint => AdminGroup) adminGroups;  // [Key]: groupId -> the AdminGroup struct

    struct Group {
        address[] groupAddressList;     //@dev - A group is a list of wallet addresses
    }
    mapping (address => Group) groups;  // [Key]: Creator address -> the Group struct

    constructor() {}

    function createAdminGroup(uint groupId) public {
        AdminGroup storage adminGroup = adminGroups[groupId];
    }

    function createGroup(address creatorAddress, address[] memory groupMembers) public {
        Group memory group = groups[creatorAddress];
        group.groupAddressList = groupMembers;
    }


    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
