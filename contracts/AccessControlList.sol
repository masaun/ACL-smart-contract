//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentUserId;   // user ID is counted from 0
    uint public currentGroupId;  // group ID is counted from 0


    //---------------------------------------
    // Storages
    //----------------------------------------
    mapping (uint => User) users;     // [Key]: user ID -> the User struct    
    mapping (uint => Group) groups;   // [Key]: group ID -> the Group struct

    //@dev - Role type: Admin user can read/write <-> member user can read only
    enum UserRole { ADMIN, MEMBER, DELETED }

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
        Group storage group = groups[groupId];
        group.adminAddresses = adminAddresses;
        group.memberAddresses = memberAddresses;
        uint groupId = currentGroupId++;
    }


    //--------------------------------------------
    // Methods for assiging/removing role of admin or member
    //---------------------------------------------
    function assignUserAsAdmin(uint groupId, address _userAddress) public returns (bool) {
        User storage user = users[userId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.ADMIN;
        uint userId = currentUserId++;

        currentAdminAddresses.push(_userAddress);
        Group storage group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    function assignUserAsMember(uint groupId, address _userAddress) public returns (bool) {
        User storage user = users[userId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.MEMBER;
        uint userId = currentUserId++;

        currentAdminAddresses.push(_userAddress);
        Group storage group = groups[groupId];
        group.memberAddresses = currentMemberAddresses;
    }


    /**
     * @dev - Remove admin role from a admin user. After that, a role status of this user become "Member"
     */ 
    function removeAdminRole(uint groupId, uint userId) public returns (bool) {
        User storage user = users[userId];
        user.userRole = UserRole.MEMBER;

        currentAdminAddresses.remove(user.userAddress);
        Group storage group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    /**
     * @dev - Remove admin role from a admin user. After that, a role status of this user become "Deleted"
     */
    function removeMemberRole(uint groupId, uint userId) public returns (bool) {
        User storage user = users[userId];
        user.userRole = UserRole.DELETED;

        currentMemberAddresses.remove(userId);
        Group storage group = groups[groupId];
        group.memberAddresses = currentMemberAddresses;
    }




    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
