# ACL Smart Contract for Lit Protocol
## 【Overview】
- This is a solidity smart contract that serves as an on-chain ACL (Access Control List).
  - This ACL smart contract includes permission and role-based governance

<br>

## 【Specifications】
- Users can have permissions (read or write) on a resource identified by a uint256 
- "admin users" should be able to set and update those permissions  
- There should be some kind of grouping mechanism for both users and admin users, with the ability to apply permissions to an entire   group, and to apply multiple groups to a resource.  
  (NOTE: More detail of specifications of this ACL smart contract is here: https://docs.google.com/document/d/1obZDbb2_i0FTYNdg6uPQWWEUdyIO51bFsTEiJdokDzk/edit )

<br>

## 【Workflow】
- Diagram that is workflow of this ACL smart contract
  - NOTE①: `AccessControlList contract (AccessControlList.sol)` is inherited by a Resource contract (Resource.sol)
    (Every Resource contract inherit AccessControlList contract in this repo)

  - NOTE②: `Resource contract (Resource.sol)` and `ResourceFactory contract (ResourceFactory.sol)` are mock contract for demo for this ACL smart contract
    (Therefore, Both contracts should be replaced depends on projects that use this ACL smart contract)
    ![diagram_ACL-smart-contract for-lit-protocol](https://user-images.githubusercontent.com/19357502/159188912-d65ea650-7e08-4c17-988e-d2567b6e78ec.jpeg)

<br>

## 【Test】
- Run a unit test of the AccessControlList.sol
```
npm run test:AccessControlList
```
( `$ npx hardhat test ./test/AccessControlList.test.js --network hardhat` )

<br>

- Run a senario test
```
npm run test:Scenario
```
( `$ npx hardhat test ./test/AccessControlList.test.js --network hardhat` )

<br>

- Run all of unit test
```
npm run test
```
( `$ npx hardhat test --network hardhat` )

<br>

## 【Demo】
- This is the demo that the test of Scenario ( `./test/Scenario.test.js` ) above that includes the whole scenario of this ACL smart contracts is executed.  
  https://youtu.be/Wc4ZrmJ-TH0  

<br>

## 【References】
- Lit Protocol: 
  - Website: https://litprotocol.com/

<br>

- Prize of the Lit Protocol (in ETH Denver): https://www.ethdenver.com/bounties/lit-protocol
  - Specifications of Access Control List (=ACL) Smart Contract: https://docs.google.com/document/d/1obZDbb2_i0FTYNdg6uPQWWEUdyIO51bFsTEiJdokDzk/edit
