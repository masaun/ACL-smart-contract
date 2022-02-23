const { expect } = require("chai")
const { ethers } = require("hardhat")


function convertHexToString(hex) {
    // [Example]: ethers.utils.arrayify("0x1234") -> Uint8Array [ 18, 52 ]
    return ethers.utils.arrayify(`${ hex }`)
}

function convertStringToHex(string) {
    // [Example]: ethers.utils.hexlify([1, 2, 3, 4]) -> '0x01020304'
    return ethers.utils.hexlify([string])
}


function toWei(amount) {
    return ethers.utils.parseEther(`${ amount }`)
}

function fromWei(amount) {
    return ethers.utils.formatEther(`${ amount }`)
}

//@dev - Method for retrieving an event log that is associated with "eventName" specified
async function getEventLog(txReceipt, eventName) {
    for (let i = 0; i < txReceipt.events.length; i++) {
        const eventLogs = txReceipt.events[i];
        console.log(`eventLogs: ${ JSON.stringify(eventLogs, null, 2) }`)

        if (eventLogs["event"] == eventName) {
            const _args = eventLogs["args"]
            return _args  // [NOTE] Return event log specified as array
        }
    }
}

async function getCurrentBlock() {}

async function getCurrentTimestamp() {}

//@dev - Export methods
module.exports = { convertHexToString, convertStringToHex, toWei, fromWei, getEventLog, getCurrentBlock, getCurrentTimestamp }
