# Simple Decentralized Access Control (DAC) using Ethereum Smart Contract

## Project Description

This project demonstrates a basic Decentralized Access Control (DAC) mechanism implemented using a Solidity smart contract. The contract is designed to be deployed on the Ethereum Sepolia test network. It allows the contract owner to grant and revoke access to a "secret file" (represented as a string) stored on the blockchain. This project is intended for educational and demonstration purposes to illustrate a simplified example of access control using blockchain technology.

## Technology Stack

*   **Solidity:** The programming language used to write the smart contract.
*   **Remix IDE:** The web-based development environment used to write, compile, deploy, and interact with the contract.
*   **MetaMask:** The browser extension used as an Ethereum wallet to interact with the Sepolia network and the smart contract.
*   **Sepolia Test Network:** The Ethereum test network used for deployment and testing.

## Contract Overview (`SimpleDAC.sol`)

The `SimpleDAC` smart contract has the following features:

*   **Owner:** The Ethereum address that deploys the contract is designated as the owner.
*   **Secret File:** A string variable (`secretFile`) that stores the data to which access is controlled.
*   **Authorized Users:** A mapping (`authorizedUsers`) that tracks which Ethereum addresses have been granted access to the secret file.

## Functions

*   **`constructor(string memory _initialSecretFile)`:**
    *   Initializes the contract when it's deployed.
    *   Sets the deploying address as the owner.
    *   Sets the `secretFile` to the `_initialSecretFile` provided during deployment.
*   **`modifier onlyOwner()`:**
    *   Restricts access to specific functions, ensuring that only the contract owner can execute them.
*   **`grantAccess(address _user)`:**
    *   Allows the owner to grant access to the `secretFile` to the specified `_user` address.
    *   Adds the `_user` to the `authorizedUsers` mapping with a value of `true`.
*   **`revokeAccess(address _user)`:**
    *   Allows the owner to revoke access to the `secretFile` from the specified `_user` address.
    *   Sets the `_user`'s value in the `authorizedUsers` mapping to `false`.
*   **`getSecretFile()`:**
    *   Allows anyone to retrieve the `secretFile` data *only if* they are the owner or have been granted access via `grantAccess`.
    *   Reverts the transaction with an "Access denied" message if the caller is not authorized.

## How to Deploy

1.  **Install MetaMask:** Install the MetaMask browser extension and create a wallet.
2.  **Switch to Sepolia:** In MetaMask, switch to the "Sepolia Test Network."
3.  **Get Sepolia ETH:** Obtain Sepolia ETH from a faucet (e.g., [https://sepoliafaucet.com/](https://sepoliafaucet.com/)).
4.  **Open Remix IDE:** Go to [https://remix.ethereum.org/](https://remix.ethereum.org/).
5.  **Create `SimpleDAC.sol`:** Create a new file named `SimpleDAC.sol` in Remix.
6.  **Paste the Code:** Paste the following Solidity code into the file:

    ```solidity
    pragma solidity ^0.8.0;

    contract SimpleDAC {
        address public owner;
        string public secretFile;
        mapping(address => bool) public authorizedUsers;

        constructor(string memory _initialSecretFile) {
            owner = msg.sender;
            secretFile = _initialSecretFile;
        }

        modifier onlyOwner() {
            require(msg.sender == owner, "Only owner can perform this action");
            _;
        }

        function grantAccess(address _user) public onlyOwner {
            authorizedUsers[_user] = true;
        }

        function revokeAccess(address _user) public onlyOwner {
            authorizedUsers[_user] = false;
        }

        function getSecretFile() public view returns (string memory) {
            require(authorizedUsers[msg.sender] || msg.sender == owner, "Access denied");
            return secretFile;
        }
    }
    ```

7.  **Compile:** In the "Solidity Compiler" tab, select compiler version 0.8.20 (or a similar 0.8.x version), and click "Compile SimpleDAC.sol."
8.  **Deploy:**
    *   Go to the "Deploy & Run Transactions" tab.
    *   Select "Injected Provider - MetaMask" as the environment.
    *   Ensure your MetaMask account with Sepolia ETH is connected.
    *   Select the "SimpleDAC" contract.
    *   Enter an initial string for `_initialSecretFile` next to Deploy button.
    *   Click "Deploy" and confirm the transaction in MetaMask.

## How to Interact

After deploying the contract:

1.  **Find Your Contract:** In the "Deploy & Run Transactions" tab, find your contract under "Deployed Contracts."
2.  **Expand the Contract:** Click the arrow next to your contract's name and address.
3.  **Interact with Functions:**
    *   **`grantAccess`:** Enter an address and click "grantAccess" to grant access.
    *   **`revokeAccess`:** Enter an address and click "revokeAccess" to revoke access.
    *   **`getSecretFile`:** Click "getSecretFile" to retrieve the secret file (only works if you are the owner or have been granted access).

## Screenshots

![image](https://github.com/user-attachments/assets/4ac3baa2-21a4-4f84-aa3c-a71d6bf0b9b3)
![image](https://github.com/user-attachments/assets/037ce0e3-01d6-45dd-b7a8-de22ff200ee6)


## Limitations

*   **Simplified Example:** This project is a basic demonstration and not suitable for production use.
*   **No Encryption:** The `secretFile` is stored as a plain string on the blockchain. In a real-world scenario, you would need to encrypt sensitive data before storing it on-chain.
*   **No Attribute-Based Access Control:** This is a simple on/off access control system. It does not implement more granular attribute-based access control (ABAC).
*   **Test Network Only:** The contract is deployed on the Sepolia test network. It should not be used with real funds or on the Ethereum Mainnet without significant modifications and security audits.

## Author

Dhawaj Kumar Tomar

## Disclaimer

This project is for educational purposes only. It is not intended for production use and has not been audited for security. Use at your own risk.
