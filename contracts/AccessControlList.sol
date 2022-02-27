//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentUserId;
    uint public currentGroupId;


    //---------------------------------------
    // Storages
    //----------------------------------------
    mapping (uint => User) users;     // [Key]: user ID -> the User struct    
    mapping (uint => Group) groups;     // [Key]: group ID -> the Group struct

    //@dev - Role type: Admin user can read/write <-> member user can read only
    enum UserRole { ADMIN, MEMBER }

    struct User {  // [Key]: user ID -> the User struct
        address userAddress;
        UserRole userRole;   // Admin or Member
    }

    address[] public currentAdminAddresses;
    address[] public currentMemberAddresses;

    struct Group {  // [Key]: group ID -> the Group struct
        address[] adminAddresses;   //@dev - list of admin's wallet addresses
        address[] memberAddresses;  //@dev - list of member's wallet addresses
    }


    constructor() {}


    //------------------------------
    // Methods for creating groups
    //------------------------------
    function createGroup(
        uint groupId, 
        address[] memory adminAddresses,   // Initial admin's addresses
        address[] memory memberAddresses   // Initial member's addresses
    ) public returns (bool)  {
        uint groupId = currentGroupId++;
        Group storage group = groups[groupId];
        group.adminAddresses = adminAddresses;
        group.memberAddresses = memberAddresses;
    }


    //--------------------------------------------
    // Methods for assiging/removing role of admin or member
    //---------------------------------------------
    function assignUserAsAdmin(uint groupId, address _userAddress) public returns (bool) {
        uint userId = currentUserId++;
        User memory user = users[userId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.ADMIN;

        currentAdminAddresses.push(_userAddress);
        Group memory group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    function assignUserAsMember(uint groupId, address _userAddress) public returns (bool) {
        uint userId = currentUserId++;
        User memory user = users[userId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.MEMBER;

        currentAdminAddresses.push(_userAddress);
        Group memory group = groups[groupId];
        group.memberAddresses = currentMemberAddresses;
    }

    function removeAdminUser(uint groupId, address existingAdminUser) public returns (bool) {
        // [TODO]:
    }

    function removeMemberUser(uint groupId, address existingMemberUser) public returns (bool) {
        // [TODO]:
    }




    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
