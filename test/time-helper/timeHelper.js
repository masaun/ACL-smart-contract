/**
 * @dev - Time-dependent tests with Hardhat
 *      - This RPC relevant methods are referenced from: https://ethereum.stackexchange.com/questions/86633/time-dependent-tests-with-hardhat
 */ 

//@dev - Returns the timestamp of the latest mined block. Should be coupled with advanceBlock to retrieve the current blockchain time.
async function getLatestTimestamp() {
    const date = new Date()                                 //@dev - Create a Date object
    const _unixTimestamp = date.getTime()                   //@dev - Get UNIX timestamp (mili-seconds)
    const unixTimestamp = Math.floor(_unixTimestamp / 1000) //@dev - Convert UNIX timestamp to seconds
    return unixTimestamp
}

//@dev - Increases the time of the blockchain by duration (in seconds), and mines a new block with that timestamp.
async function increaseTime(duration) {
    // [TODO]: Replace
    // suppose the current block has a timestamp of 01:00 PM
    await network.provider.send("evm_increaseTime", [duration])
    await network.provider.send("evm_mine") // this one will have 02:00 PM as its timestamp
}

//@dev - Same as increase, but a target time is specified instead of a duration.
async function increaseTimeTo(target) {
    // [TODO]: Replace
    //return await time.increaseTo(target)
}

//@dev - Export methods
module.exports = { getLatestTimestamp, increaseTime, increaseTimeTo }
