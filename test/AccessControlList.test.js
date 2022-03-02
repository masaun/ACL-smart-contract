const { expect } = require("chai")
const { ethers } = require("hardhat")


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
    })

    it("Deploy the AccessControlList.sol", async function () {
        const AccessControlList = await ethers.getContractFactory("AccessControlList")
        acl = await AccessControlList.deploy()
        await acl.deployed()
    })


    ///-------------------------------------------------------
    /// Test of methods defined in the AccessControlList.sol
    ///-------------------------------------------------------

    it("createGroup()", async function () {
        let tx = await acl.connect(user1).createGroup()
        let txReceipt = await tx.wait()
    })

    it("assignUserAsAdmin()", async function () {
        const groupId = 0
        const userAddress = USER_1

        let tx = await acl.connect(user1).assignUserAsAdmin(groupId, userAddress)
        let txReceipt = await tx.wait()
    })

    it("assignUserAsMember()", async function () {
        const groupId = 0
        const userAddress = USER_2

        let tx = await acl.connect(user2).assignUserAsAdmin(groupId, userAddress)
        let txReceipt = await tx.wait()
    })

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
