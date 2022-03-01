//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentUserId;   // user ID is counted from 0
    uint public currentGroupId;  // group ID is counted from 0

    address[] public currentAdminAddresses;
    address[] public currentMemberAddresses;

    //----------------------------------------
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

    struct Group {  // [Key]: group ID -> the Group struct
        address[] adminAddresses;   //@dev - list of admin's wallet addresses
        address[] memberAddresses;  //@dev - list of member's wallet addresses
    }


    //-----------------
    // Constructor
    //-----------------
    constructor() {}


    //-----------------
    // Modifiers
    //-----------------

    /**
     * @dev - Check permission (Read/Write) for admin users 
     */ 
    modifier permissionForAdmin(address user) {
        //@dev - Check whether a user specified has an admin role or not 
        for (uint i=0; i < currentAdminAddresses.length; i++) {
            address adminAddress = currentAdminAddresses[i];
            
            require (user == adminAddress, "User must has an admin role");
            _;
        }
    }

    /**
     * @dev - Check permission (Read only) for member users 
     */ 
    modifier permissionForMember(address user) { 
        //@dev - Check whether a user specified has a member role or not 
        for (uint i=0; i < currentMemberAddresses.length; i++) {
            address memberAddress = currentMemberAddresses[i];
            
            require (user == memberAddress, "User must has an member role");
            _;
        }
    }


    //------------------------------
    // Methods for creating groups
    //------------------------------
    function createGroup() public returns (bool)  {
        Group storage group = groups[currentGroupId];
        group.adminAddresses = currentAdminAddresses;
        group.memberAddresses = currentMemberAddresses;
        currentGroupId++;
    }


    //-------------------------------------------------------
    // Methods for assiging/removing role of admin or member
    //-------------------------------------------------------

    /**
     * @dev - Assign a user address as a admin role
     * @param groupId - group ID that a user address is assigned (as a admin role)
     * @param _userAddress - User address that is assigned as a admin role
     */ 
    function assignUserAsAdmin(uint groupId, address _userAddress) public returns (bool) {
        User storage user = users[currentGroupId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.ADMIN;
        currentUserId++;

        currentAdminAddresses.push(_userAddress);
        Group storage group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    /**
     * @dev - Assign a user address as a member role
     * @param groupId - group ID that a user address is assigned (as a member role)
     * @param _userAddress - User address that is assigned as a member role
     */ 
    function assignUserAsMember(uint groupId, address _userAddress) public returns (bool) {
        User storage user = users[currentUserId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.MEMBER;
        currentUserId++;

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

        for (uint i=0; i < currentAdminAddresses.length; i++) {
            address adminAddress = currentAdminAddresses[i];
            if (adminAddress == user.userAddress) {
                delete currentAdminAddresses[i];
            }
        }

        Group storage group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    /**
     * @dev - Remove admin role from a admin user. After that, a role status of this user become "Deleted"
     */
    function removeMemberRole(uint groupId, uint userId) public returns (bool) {
        User storage user = users[userId];
        user.userRole = UserRole.DELETED;

        for (uint i=0; i < currentMemberAddresses.length; i++) {
            address memberAddress = currentMemberAddresses[i];
            if (memberAddress == user.userAddress) {
                delete currentMemberAddresses[i];
            }
        }

        Group storage group = groups[groupId];
        group.memberAddresses = currentMemberAddresses;
    }




    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
