const { expect } = require("chai")
const { ethers } = require("hardhat")


describe("AccessControlList", function () {
    it("Deploy the AccessControlList.sol", async function () {
        const AccessControlList = await ethers.getContractFactory("AccessControlList")
        const acl = await AccessControlList.deploy()
        await acl.deployed()
    })
})
