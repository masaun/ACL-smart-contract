//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AccessControlList {

    uint public currentAdminGroupId;
    uint public currentMemberGroupId;

    //@dev - Role type
    //@dev - Admin user can read/write <-> member user can read only
    enum UserRole { ADMIN, MEMBER }

    //---------------------------------------
    // Storages
    //----------------------------------------
    mapping (uint => AdminGroup) adminGroups;     // [Key]: admin group ID -> the AdminGroup struct
    mapping (uint => MemberGroup) memberGroups;   // [Key]: member group ID -> the Group struct

    struct AdminGroup {
        address[] adminGroupAddresses;   //@dev - list of admin's wallet addresses
    }

    struct MemberGroup {
        address[] memberGroupAddresses;   //@dev - list of member's wallet addresses
    }

    constructor() {}

    //------------------------------
    // Methods for creating groups
    //------------------------------
    function createAdminGroup(uint adminGroupId, address[] memory admins) public returns (bool)  {
        uint adminGroupId = currentAdminGroupId++;
        AdminGroup storage adminGroup = adminGroups[adminGroupId];
        adminGroup.adminGroupAddresses = admins;
    }

    function createMemberGroup(uint memberGroupId, address[] memory members) public returns (bool) {
        uint memberGroupId = currentMemberGroupId++;
        MemberGroup storage memberGroup = memberGroups[memberGroupId];
        memberGroup.memberGroupAddresses = members;
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
