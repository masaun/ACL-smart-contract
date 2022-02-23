//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AccessControlList {

    struct Group {
        address[] groupAddressList;     //@dev - A group is a list of wallet addresses
    }
    mapping (address => Group) groups;  // [Key]: Creator address -> the Group struct

    constructor() {}

    function createAdminGroup() public {}

    function createGroup(address creatorAddress, address[] memory groupMembers) public {
        Group memory group = groups[creatorAddress];
        group.groupAddressList = groupMembers;
    }


    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
