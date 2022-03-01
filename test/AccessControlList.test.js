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
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners()
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
        let tx = await acl.connect(owner).createGroup()
        let txReceipt = await tx.wait()
    })

    it("assignUserAsAdmin()", async function () {
        // [TODO]:
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
