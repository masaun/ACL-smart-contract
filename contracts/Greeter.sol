//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Greeter {
    string private greeting;

    struct Greet {
        uint greetNumber;
        string greetingMessage;
    }
    mapping (uint => Greet) greets;


    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function getGreet() public view returns (Greet memory _greet) {
        Greet storage greet = greets[0];
        return greet;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;

        //@dev - Test for storage of mapping type
        Greet storage greet = greets[0];
        greet.greetNumber = 111;
        greet.greetingMessage = "Example Message!!";
    }
}
