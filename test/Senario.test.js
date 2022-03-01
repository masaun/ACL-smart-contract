const { expect } = require("chai")
const { ethers } = require("hardhat")


describe("Senario Test", function () {
    it("Deploy the AccessControlList.sol", async function () {
        const AccessControlList = await ethers.getContractFactory("AccessControlList")
        const acl = await AccessControlList.deploy()
        await acl.deployed()
    })
})
