const { ethers } = require("hardhat")

async function main() {

    //@dev - Deployed-address of the Greeter.sol on Metis Testnet
    const GREETER = "0x0821bF0921b19289FB30A8EA0fD65F751F3dc9bB"

    //@dev - Get signers
    const [deployerSign] = await ethers.getSigners()
    //const [deployerSign, user1Sign] = await ethers.getSigners()
    console.log(`deployer address: ${ deployerSign.address }`)
    //console.log(`user1 address: ${ user1Sign.address }`)

    //@dev - Create the contract instance
    const greeter = await ethers.getContractAt("Greeter", GREETER)
  
    //@dev - Execute setGreeting() method
    const _greeting = "Hi! This is a greeting message!!"
    let transaction = await greeter.connect(deployerSign).setGreeting(_greeting)
    let txReceipt = await transaction.wait()
    console.log(`txReceipt of setGreeting() method: ${ JSON.stringify(txReceipt, null, 2) }`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
