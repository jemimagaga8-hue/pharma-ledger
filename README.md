# 🧬 Pharma-Ledger: DeSci Clinical Trial Vault

A decentralized science (DeSci) smart contract protocol built to guarantee the absolute integrity and immutability of clinical trial data. 

In the medical research industry, data tampering and missing trial results are massive liabilities. Pharma-Ledger solves this by allowing authorized researchers to anchor immutable IPFS hashes of their clinical trial results directly to the blockchain, creating a transparent and tamper-proof public ledger.

## 🚀 Key Features

*   **Role-Based Access Control (RBAC):** Built with OpenZeppelin's `Ownable` standard. Only the contract administrator can authorize or revoke researcher wallets, preventing spam and fraudulent data entries.
*   **Immutable Data Anchoring:** Stores critical trial metadata on-chain, while the heavy, raw research data is hosted off-chain via IPFS.
*   **Event-Driven Architecture:** Fully indexed events (`TrialUploaded`) allow off-chain applications, front-ends, and CRM automations to listen for real-time updates seamlessly.
*   **Gas-Optimized:** Clean, mapping-based storage architecture ensures low transaction costs for researchers.

## 🛠️ Technology Stack

*   **Language:** Solidity (^0.8.33)
*   **Framework:** Foundry
*   **Security:** OpenZeppelin Contracts
*   **Storage Architecture:** On-Chain Hashes + Off-Chain IPFS

## 💻 Quick Start & Testing

This project is built using Foundry. To compile and run the comprehensive testing suite:

1. **Install Dependencies:**
   ```bash
   forge install# pharma-ledger
# pharma-ledger
