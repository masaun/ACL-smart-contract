const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    // Storage test 
    const _greet = await greeter.getGreet()
    console.log(`greet: ${ _greet }`)
    console.log(`greetNumber: ${ _greet[0] }`)
    console.log(`greetMessage: ${ _greet[1] }`)

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
