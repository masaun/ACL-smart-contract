const { expect } = require("chai")
const { ethers } = require("hardhat")

//@dev - ethers.js related methods
const { toWei, fromWei, getEventLog, getCurrentBlock, getCurrentTimestamp } = require('./ethersjs-helper/ethersjsHelper')


describe("AccessControlList", function () {

    //@dev - Contract instance
    let acl

    //@dev - Contract addresses
    let ACL

    //@dev - Signers of wallet addresses
    let deployer
    let user1, user2
    let users

    //@dev - Wallet addresses
    let DEPLOYER
    let USER_1, USER_2

    before(async function () {
        [deployer, user1, user2, ...users] = await ethers.getSigners()

        DEPLOYER = deployer.address
        USER_1 = user1.address
        USER_2 = user2.address
        console.log(`USER_1: ${ USER_1 }`)
        console.log(`USER_2: ${ USER_2 }`)
    })

    it("Deploy the AccessControlList.sol", async function () {
        const AccessControlList = await ethers.getContractFactory("AccessControlList")
        acl = await AccessControlList.deploy()
        await acl.deployed()
        ACL = acl.address
        console.log(`ACL: ${ ACL }`)
    })


    ///-------------------------------------------------------
    /// Test of methods defined in the AccessControlList.sol
    ///-------------------------------------------------------

    it("createGroup()", async function () {
        let tx = await acl.connect(user1).createGroup()
        let txReceipt = await tx.wait()

        //@dev - Retrieve an event log of "GroupCreated"
        let eventLog = await getEventLog(txReceipt, "GroupCreated")
        console.log(`eventLog of GroupCreated: ${ eventLog }`)
    })

    it("assignUserAsAdminRole()", async function () {
        const groupId = 0
        const userAddress = USER_1

        let tx = await acl.connect(user1).assignUserAsAdminRole(groupId, userAddress)
        let txReceipt = await tx.wait()

        //@dev - Retrieve an event log of "GroupCreated"

    })

    it("assignUserAsMemberRole()", async function () {
        const groupId = 0
        const userAddress = USER_2

        let tx = await acl.connect(user2).assignUserAsMemberRole(groupId, userAddress)
        let txReceipt = await tx.wait()
    })


    ///--------------------------------
    /// Check 
    ///--------------------------------
    it("getGroup()", async function () {
        const groupId = 0
        let group = await acl.getGroup(groupId)
        console.log(`group: ${ group }`)
    })

    it("getUser()", async function () {
        const userId0 = 0
        let user0 = await acl.getUser(userId0)

        const userId1 = 1
        let user1 = await acl.getUser(userId1)

        console.log(`user0: ${ user0 }`)
        console.log(`user1: ${ user1 }`)
    })

    it("getUserAddresses()", async function () {
        let users = await acl.getUserAddresses()
        console.log(`userAddresses: ${ users }`)
    })


    ///--------------------------------
    /// Test that remove roles 
    ///--------------------------------
    it("removeAdminRole()", async function () {
        const groupId = 0
        const userId = 0

        let tx = await acl.connect(user1).removeAdminRole(groupId, userId)
        let txReceipt = await tx.wait()
    })

    it("removeMemberRole()", async function () {
        const groupId = 0
        const userId = 1

        let tx = await acl.connect(user2).removeMemberRole(groupId, userId)
        let txReceipt = await tx.wait()
    })

})
