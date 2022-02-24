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

    mapping (uint => AdminGroup) adminGroups;     // [Key]: admin group ID -> the AdminGroup struct
    mapping (uint => MemberGroup) memberGroups;   // [Key]: member group ID -> the Group struct
    mapping (uint => Group) groups;               // [Key]: member group ID -> the Group struct

    struct Admin {  // [Key]: Admin ID -> the AdminUser struct
        address adminAddress;
        UserRole userRole;
    }

    struct Member {  // [Key]: Member ID -> the AdminUser struct
        address memberAddress;
        UserRole userRole;
    }

    struct AdminGroup {
        address[] adminGroupAddresses;   //@dev - list of admin's wallet addresses
    }

    struct MemberGroup {
        address[] memberGroupAddresses;   //@dev - list of member's wallet addresses
    }

    struct Group {
        address adminAddress;
        address[] memberAddresses;
    }


    constructor() {}

    //------------------------------
    // Methods for creating groups
    //------------------------------
    function createGroup(uint groupId, address admin, address[] memory memberAddresses) public returns (bool)  {
        uint groupId = currentGroupId++;
        Group storage group = groups[groupId];
        group.adminAddress = admin;
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
    // Methods for assiging/removing role
    //---------------------------------------------
    function assignRole(uint groupId, address user) public returns (bool) {
        // [TODO]:

    }

    function removeRole(uint groupId, address user) public returns (bool) {
        // [TODO]:
    }






    //-------------------
    // Getter methods
    //-------------------
    function get() public view returns (string memory) {}

}
