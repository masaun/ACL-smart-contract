//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentAdminGroupId;
    uint public currentMemberGroupId;
    uint public currentGroupId;

    //@dev - Role type
    //@dev - Admin user can read/write <-> member user can read only
    enum UserRole { ADMIN, MEMBER }

    //---------------------------------------
    // Storages
    //----------------------------------------
    mapping (uint => Admin) admins;     // [Key]: admin ID -> the Admin struct
    mapping (uint => Member) members;   // [Key]: member ID -> the Member struct
    mapping (uint => Group) groups;     // [Key]: group ID -> the Group struct

    struct Admin {  // [Key]: Admin ID -> the AdminUser struct
        address adminAddress;
    }

    struct Member {  // [Key]: Member ID -> the AdminUser struct
        address memberAddress;
    }

    address[] adminGroupAddresses;   //@dev - list of admin's wallet addresses
    address[] memberGroupAddresses;   //@dev - list of member's wallet addresses

    struct Group {
        address[] adminAddresses;
        address[] memberAddresses;
    }


    constructor() {}

    //------------------------------
    // Methods for creating groups
    //------------------------------
    function createGroup(uint groupId, address[] memory adminAddresses, address[] memory memberAddresses) public returns (bool)  {
        uint groupId = currentGroupId++;
        Group storage group = groups[groupId];
        group.adminAddresses = adminAddresses;
        group.memberAddresses = memberAddresses;
    }

    function createAdminGroup(uint adminGroupId, address[] memory admins) public returns (bool)  {
        uint adminGroupId = currentAdminGroupId++;
        AdminGroup storage adminGroup = adminGroups[adminGroupId];
        adminGroup.adminGroupAddresses = admins;
        //adminGroup.userRole = UserRole.ADMIN;
    }

    function createMemberGroup(uint memberGroupId, address[] memory members) public returns (bool) {
        uint memberGroupId = currentMemberGroupId++;
        MemberGroup storage memberGroup = memberGroups[memberGroupId];
        memberGroup.memberGroupAddresses = members;
        //memberGroup.userRole = UserRole.MEMBER;
    }


    //--------------------------------------------
    // Methods for assiging/removing role of admin or member
    //---------------------------------------------
    function assignAdmin(uint groupId, address user, UserRole userRole) public returns (bool) {
        Group memory group = groups[groupId];
        group.adminAddresses = adminGroupAddresses.push(user);
    }

    function assignMember(uint groupId, address user, UserRole userRole) public returns (bool) {
        Group memory group = groups[groupId];
        address[] memory currentMemberAddresses = group.memberAddresses;
        group.memberAddresses = currentMemberAddresses.push(user);
    }

    function removeAdmin(uint groupId, address existingAdmin) public returns (bool) {
        // [TODO]:
    }

    function removeMember(uint groupId, address existingMember) public returns (bool) {
        // [TODO]:
    }




    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
