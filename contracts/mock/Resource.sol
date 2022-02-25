//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Resource {

    //@dev - In progress
    struct ResourceMetadata {
        address contentAddress;
        uint amount;
    }
    mapping (address => ResourceMetadata) resourceMetadatas;  //@dev - Only 

    constructor() {}

    function something() public returns (bool) {}

}
