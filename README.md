# Reentrancy Attack in Ethereum Smart Contracts

## Project Overview
This project demonstrates the reentrancy attack vulnerability in Ethereum smart contracts using Solidity.

## Tools Used
- Remix IDE
- Solidity

## Description
A vulnerable smart contract is created which allows users to deposit and withdraw Ether. Due to improper state update, it becomes vulnerable to reentrancy attack.

An attacker contract exploits this vulnerability by repeatedly calling the withdraw function before the balance is updated.

## Steps Performed
1. Deployed vulnerable contract
2. Deposited 5 ETH
3. Deployed attacker contract
4. Executed attack with 1 ETH
5. Observed attacker balance increase to 6 ETH

## Result
The attacker successfully drained funds due to recursive calls, demonstrating a reentrancy vulnerability.

## Conclusion
This project highlights the importance of secure smart contract design and proper state management.
