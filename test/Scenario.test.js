const { expect } = require("chai")
const { ethers } = require("hardhat")

//@dev - ethers.js related methods
const { toWei, fromWei, getEventLog, getCurrentBlock, getCurrentTimestamp } = require('./ethersjs-helper/ethersjsHelper')


describe("Scenario Test", function () {
    //@dev - Contract instance
    let resourceFactory
    let resource

    //@dev - Contract addresses
    let RESOURCE_FACTORY
    let RESOURCE

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

    it("Deploy the ResourceFactory.sol (that the AccessControlList.sol is inherited)", async function () {
        const ResourceFactory = await ethers.getContractFactory("ResourceFactory")
        resourceFactory = await ResourceFactory.deploy()
    })

    it("Create a resource", async function () {
        let tx = await resourceFactory.connect(user1).createNewResource()
        let txReceipt = await tx.wait()

        let currentResourceId = await resourceFactory.getCurrentResourceId()
        console.log(`currentResourceId: ${ currentResourceId }`)  // [Retunr]: 1

        let resourceId = await Number(currentResourceId) - 1
        console.log(`resourceId: ${ resourceId }`)                // [Retunr]: 0

        RESOURCE = await resourceFactory.getResource(resourceId)
        console.log(`RESOURCE: ${ RESOURCE }`)

        let Resource = await ethers.getContractFactory("Resource")
        resource = await ethers.getContractAt("Resource", RESOURCE)
    })


    ///-------------------------------------------------------
    /// Test of methods defined in the AccessControlList.sol
    /// (These methods are executed via Resource.sol
    ///-------------------------------------------------------

    it("createGroup()", async function () {
        let tx = await resource.connect(user1).createGroup()
        let txReceipt = await tx.wait()

        //@dev - Retrieve an event log of "GroupCreated"
        let eventLog = await getEventLog(txReceipt, "GroupCreated")
        console.log(`eventLog of GroupCreated: ${ eventLog }`)
    })

    it("assignUserAsAdminRole()", async function () {
        const groupId = 0
        const userAddress = USER_1

        let tx = await resource.connect(user1).assignUserAsAdminRole(groupId, userAddress)
        let txReceipt = await tx.wait()
    })

    it("assignUserAsMemberRole()", async function () {
        const groupId = 0
        const userAddress = USER_2

        let tx = await resource.connect(user2).assignUserAsMemberRole(groupId, userAddress)
        let txReceipt = await tx.wait()
    })


    ///--------------------------------
    /// Check 
    ///--------------------------------
    it("getGroup()", async function () {
        const groupId = 0
        let group = await resource.connect(user1).getGroup(groupId)
        console.log(`group: ${ group }`)
    })

    it("getUser()", async function () {
        const userId0 = 0
        let user0 = await resource.getUser(userId0)

        const userId1 = 1
        let user1 = await resource.getUser(userId1)

        console.log(`user0: ${ user0 }`)
        console.log(`user1: ${ user1 }`)
    })


    ///-------------------------------------------------------
    /// Test of methods defined in the Resource.sol
    ///-------------------------------------------------------
    it("createNewResourceMetadata()", async function () {
        const resourceName = "Example Resource 1"
        const resourceURI = "ipfs://QmbWqxBEKC3P8tqsKc98xmWNzrzDtRLMiMPL8wBuTGsMnR"

        let tx = await resource.connect(user1).createNewResourceMetadata(resourceName, resourceURI)
        let txReceipt = await tx.wait()
    })

    it("getResourceMetadata() - Only user who has admin role or member role should be able to call this method", async function () {
        let resourceMetadata = await resource.connect(user2).getResourceMetadata()
        let _resourceName = resourceMetadata.resourceName
        let _resourceURI = resourceMetadata.resourceURI
        console.log(`resourceMetadata: ${ resourceMetadata }`)
        console.log(`resourceName: ${ _resourceName }`)
        console.log(`resourceURI: ${ _resourceURI }`)
    })


    ///--------------------------------
    /// Test that remove roles 
    ///--------------------------------
    it("removeAdminRole()", async function () {
        const groupId = 0
        const userId = 0

        let tx = await resource.connect(user1).removeAdminRole(groupId, userId)
        let txReceipt = await tx.wait()
    })

    it("removeMemberRole()", async function () {
        const groupId = 0
        const userId = 1

        let tx = await resource.connect(user2).removeMemberRole(groupId, userId)
        let txReceipt = await tx.wait()
    })



})