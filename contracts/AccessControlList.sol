//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentUserId;   // user ID is counted from 0
    uint public currentGroupId;  // group ID is counted from 0

    address[] public userAddresses;

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

    event GroupCreated(
        uint groupId,
        address creator,
        address[] adminAddresses,
        address[] memberAddresses
    );


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
    modifier onlyAdminRole(address user) {
        //@dev - Check whether a user specified has an admin role or not 
        for (uint i=0; i < currentAdminAddresses.length; i++) {
            address adminAddress = currentAdminAddresses[i];
            
            require (user == adminAddress, "Only user who has an admin role can access this resources");
            _;
        }
    }

    /**
     * @dev - Check permission (Read only) for member users 
     */ 
    modifier onlyMemberRole(address user) { 
        //@dev - Check whether a user specified has a member role or not 
        for (uint i=0; i < currentMemberAddresses.length; i++) {
            address memberAddress = currentMemberAddresses[i];
            
            require (user == memberAddress, "Only user who has an member role can access this resources");
            _;
        }
    }

    /**
     * @dev - Check whether a user is already registered or not. (Chekch whether a user already has a User ID or not)
     */
    modifier checkWhetherUserIsAlreadyRegisteredOrNot(address user) {
        for (uint i=0; i < userAddresses.length; i++) {
            require (user == userAddresses[i], "This user is already registered");
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

        emit GroupCreated(currentGroupId, msg.sender, group.adminAddresses, group.memberAddresses);

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
    function assignUserAsAdminRole(uint groupId, address _userAddress) public checkWhetherUserIsAlreadyRegisteredOrNot(_userAddress) returns (bool) {
        User storage user = users[currentUserId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.ADMIN;
        userAddresses.push(_userAddress);
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
    function assignUserAsMemberRole(uint groupId, address _userAddress) public checkWhetherUserIsAlreadyRegisteredOrNot(_userAddress) returns (bool) {
        User storage user = users[currentUserId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.MEMBER;
        userAddresses.push(_userAddress);
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
    function getGroup(uint groupId) public view returns (Group memory _group) {
        return groups[groupId];
    }

    function getUser(uint userId) public view returns (User memory _user) {
        return users[userId];
    }

}
