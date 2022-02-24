# ACL Smart Contract for Lit Protocol
## 【Overview】
- This is a solidity smart contract that serves as an on-chain ACL (Access Control List).

<br>

- Main specifications: 
  - Users can have permissions (read or write) on a resource identified by a uint256 
  - "admin users" should be able to set and update those permissions  
  - There should be some kind of grouping mechanism for both users and admin users, with the ability to apply permissions to an entire   group, and to apply multiple groups to a resource.  
    https://docs.google.com/document/d/1obZDbb2_i0FTYNdg6uPQWWEUdyIO51bFsTEiJdokDzk/edit 

<br>

## 【Deployment】on Metis Testnet
- Deploy a sample contract on Metis Testnet
```
npm run deploy-metis_testnet:Sample
```
( `$ npx hardhat run scripts/deployment/00_deploy_Sample.js --network metis_testnet` )

<br>

## 【Script】
- Run a sample script
```
npm run script-metis_testnet:Sample
```
( `$ npx hardhat run scripts/sample-script.js --network metis_testnet` )

<br>

## 【Test】
- Run a unit test of the Something.sol
```
npm run test:Something
```
( `$ npx hardhat test ./test/Something.test.js --network hardhat` )

<br>

- Run all of unit test
```
npm run test
```
( `$ npx hardhat test --network hardhat` )

<br>

- Run a senario test
```
npm run test:Scenario
```
( `$ npx hardhat test ./test/scenario.test.js --network hardhat` )

<br>

## 【References】
- Prize of the Lit Protocol (in ETH Denver)：https://www.ethdenver.com/bounties/lit-protocol
  - Specifications of Access Control List (= ACL ) Smart Contract: https://docs.google.com/document/d/1obZDbb2_i0FTYNdg6uPQWWEUdyIO51bFsTEiJdokDzk/edit
