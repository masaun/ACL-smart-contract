const { expect } = require("chai")
const { ethers } = require("hardhat")


describe("AccessControlList", function () {
    it("Deploy the AccessControlList.sol", async function () {
        const AccessControlList = await ethers.getContractFactory("AccessControlList")
        const acl = await AccessControlList.deploy()
        await acl.deployed()
    })


    ///-----------------------
    /// Test of main methods
    ///-----------------------

    it("createGroup()", async function () {
        // [TODO]:
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
