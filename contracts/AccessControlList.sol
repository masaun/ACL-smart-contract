//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

//@notice - OpenZepelin
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

//@notice - Debug
import "hardhat/console.sol";


contract AccessControlList is Ownable {

    uint public currentUserId;   // user ID is counted from 0
    uint public currentGroupId;  // group ID is counted from 0

    address[] public userAddresses;

    address[] public currentAdminAddresses;
    address[] public currentMemberAddresses;


    //----------------------------------------
    // Storages
    //----------------------------------------
    mapping (uint => User) users;     // [Key]: user ID -> the User struct
    mapping (address => UserByAddress) userByAddresses;     // [Key]: user's address -> the UserByAddress struct 
    mapping (uint => Group) groups;   // [Key]: group ID -> the Group struct

    //@dev - Role type: Admin user can read/write <-> member user can read only
    enum UserRole { ADMIN, MEMBER, DELETED }

    struct User {  // [Key]: user ID -> the User struct
        address userAddress;
        UserRole userRole;   // Admin or Member
    }

    struct UserByAddress {  // [Key]: user's wallet address -> the User struct
        uint userId;
        UserRole userRole;  // Admin or Member
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

    event UserAsAdminRoleAssigned(
        // [TODO]:
    );

    event UserAsMemberRoleAssigned(
        // [TODO]:
    );


    //-----------------
    // Modifiers
    //-----------------

    /**
     * @dev - Check permission that only users who has an admin role can access resources
     * @dev - Check whether a user specified has an admin role or not
     */
    modifier onlyAdminRole(address user) {
        UserRole _userRole = getUserByAddress(user).userRole;

        //@dev - If a role of "user" is "ADMIN", this condition below can be passed. 
        //@dev - Only case that a role of "user" is not "ADMIN", this error message below is displayed
        require (_userRole == UserRole.ADMIN, "Only users who has an admin role can access this resources");
        _;
    }

    /**
     * @dev - Check a permission that only users who has a member role can access resources
     */ 
    modifier onlyMemberRole(address user) { 
        UserRole _userRole = getUserByAddress(user).userRole;

        //@dev - If a role of "user" is "MEMBER", this condition below can be passed. 
        //@dev - Only case that a role of "user" is not "MEMBER", this error message below is displayed
        require (_userRole == UserRole.MEMBER, "Only users who has a member role can access this resources");
        _;
    }

    /**
     * @dev - Check a permission that only users who has admin role or member role can access resources
     */ 
    modifier onlyAdminOrMemberRole(address user) { 
        UserRole _userRole = getUserByAddress(user).userRole;

        //@dev - If a role of "user" is "MEMBER", this condition below can be passed. 
        //@dev - Only case that a role of "user" is not "MEMBER", this error message below is displayed
        require (_userRole == UserRole.ADMIN || _userRole == UserRole.MEMBER, "Only users who has an admin role or a member role can access this resources");
        _;
    }


    /**
     * @dev - Check whether a user is already registered or not. (Chekch whether a user already has a User ID or not)
     */
    // [TODO]: Need to fix this modifier method
    // modifier checkWhetherUserIsAlreadyRegisteredOrNot(address user) {
    //     for (uint i=0; i < userAddresses.length; i++) {
    //         require (user == userAddresses[i], "This user is already registered");
    //         _;
    //     }
    // }


    //-----------------
    // Constructor
    //-----------------
    constructor() {
        createGroup();

        uint _groupId = getCurrentGroupId() - 1;
        assignContractCreatorAsInitialAdminRole(_groupId);
    }


    //------------------------------
    // Methods for creating groups
    //------------------------------
    function createGroup() public returns (bool) {
        Group storage group = groups[currentGroupId];
        group.adminAddresses = currentAdminAddresses;
        group.memberAddresses = currentMemberAddresses;

        emit GroupCreated(currentGroupId, msg.sender, group.adminAddresses, group.memberAddresses);

        currentGroupId++;
    }


    //-------------------------------------------------------
    // Methods for assiging/updating/removing role of admin or member
    //-------------------------------------------------------

    /**
     * @dev - Assign a contract creator's address as a initial admin role
     * @param groupId - group ID that a user address is assigned (as a admin role)
     */
    function assignContractCreatorAsInitialAdminRole(uint groupId) public onlyOwner returns (bool) {
        console.log("############################## currentUserId", currentUserId);

        address _userAddress = msg.sender;  //@dev - msg.sender is a contract creator's address

        User storage user = users[currentUserId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.ADMIN;

        UserByAddress storage userByAddress = userByAddresses[_userAddress];
        userByAddress.userId = currentUserId;
        userByAddress.userRole = UserRole.ADMIN;

        userAddresses.push(_userAddress);
        currentUserId++;

        currentAdminAddresses.push(_userAddress);
        Group storage group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    /**
     * @dev - Assign a user address as a admin role
     * @param groupId - group ID that a user address is assigned (as a admin role)
     * @param _userAddress - User address that is assigned as a admin role
     */
    function assignUserAsAdminRole(uint groupId, address _userAddress) public onlyAdminRole(msg.sender) returns (bool) {
    // function assignUserAsAdminRole(uint groupId, address _userAddress) public checkWhetherUserIsAlreadyRegisteredOrNot(_userAddress) returns (bool) {
        console.log("############################## currentUserId", currentUserId);

        User storage user = users[currentUserId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.ADMIN;

        UserByAddress storage userByAddress = userByAddresses[_userAddress];
        userByAddress.userId = currentUserId;
        userByAddress.userRole = UserRole.ADMIN;

        userAddresses.push(_userAddress);
        currentUserId++;

        currentAdminAddresses.push(_userAddress);
        Group storage group = groups[groupId];
        group.adminAddresses = currentAdminAddresses;
    }

    /**
     * @dev - Assign a user address as a member role
     * @dev - This method can be called by users who has an admin role only 
     * @param groupId - group ID that a user address is assigned (as a member role)
     * @param _userAddress - User address that is assigned as a member role
     */ 
    function assignUserAsMemberRole(uint groupId, address _userAddress) onlyAdminRole(msg.sender) public returns (bool) {
    //function assignUserAsMemberRole(uint groupId, address _userAddress) public checkWhetherUserIsAlreadyRegisteredOrNot(_userAddress) returns (bool) {
        User storage user = users[currentUserId];
        user.userAddress = _userAddress;
        user.userRole = UserRole.MEMBER;

        UserByAddress storage userByAddress = userByAddresses[_userAddress];
        userByAddress.userId = currentUserId;
        userByAddress.userRole = UserRole.MEMBER; 

        userAddresses.push(_userAddress);
        currentUserId++;

        currentMemberAddresses.push(_userAddress);
        Group storage group = groups[groupId];
        group.memberAddresses = currentMemberAddresses;
    }

    /**
     * @dev - Remove admin role from a admin user. After that, a role status of this user become "Member"
     */ 
    function removeAdminRole(uint groupId, uint userId) public onlyAdminRole(msg.sender) returns (bool) {
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
    function removeMemberRole(uint groupId, uint userId) public onlyAdminOrMemberRole(msg.sender) returns (bool) {
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
    function getCurrentGroupId() public view returns (uint _currentGroupId) {
        return currentGroupId;
    }

    function getCurrentUserId() public view returns (uint _currentUserId) {
        return currentUserId;
    }

    function getGroup(uint groupId) public view returns (Group memory _group) {
        return groups[groupId];
    }

    function getUser(uint userId) public view returns (User memory _user) {
        return users[userId];
    }

    function getUserByAddress(address user) public view returns (UserByAddress memory _userByAddress) {
        UserByAddress memory userByAddress = userByAddresses[user];
        return userByAddress;
    }

    function getUserAddresses() public view returns (address[] memory _users) {
        return userAddresses;
    }

    function getCurrentAdminAddresses() public view returns (address[] memory _currentAdminAddresses) {
        return currentAdminAddresses;
    }
 
    function getCurrentMemberAddresses() public view returns (address[] memory _currentMemberAddresses) {
        return currentMemberAddresses;
    }

}
