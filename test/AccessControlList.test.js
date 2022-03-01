const { expect } = require("chai")
const { ethers } = require("hardhat")


describe("AccessControlList", function () {

    //@dev - Wallet address
    let owner
    let addr1
    let addr2
    let addrs

    //@dev - Contract instance
    let acl

    //before(async function () {
    beforeEach(async function () {
        [deployer, user1, user2, ...addrs] = await ethers.getSigners()
    })


    it("Deploy the AccessControlList.sol", async function () {
        const AccessControlList = await ethers.getContractFactory("AccessControlList")
        acl = await AccessControlList.deploy()
        await acl.deployed()
    })


    ///-----------------------
    /// Test of main methods
    ///-----------------------

    it("createGroup()", async function () {
        let tx = await acl.connect(user1).createGroup()
        let txReceipt = await tx.wait()
    })

    it("assignUserAsAdmin()", async function () {
        const groupId = 0
        const userAddress = user1.address

        let tx = await acl.connect(user1).assignUserAsAdmin(groupId, userAddress)
        let txReceipt = await tx.wait()
    })

    it("assignUserAsMember()", async function () {
        // [TODO]:
    })

    it("removeAdminRole()", async function () {
        // [TODO]:
    })

    it("removeMemberRole()", async function () {
        // [TODO]:
    })

})
