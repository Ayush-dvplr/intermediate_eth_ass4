# DeganToken Smart Contract

This Solidity program is a simple implementation of an ERC20 token named DeganToken, demonstrating the basic syntax and functionality of the Solidity programming language. The purpose of this program is to serve as a starting point for those who are new to Solidity and want to understand the creation and management of tokens on the Ethereum blockchain.

## Description

This DeganToken contract is written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract includes functionalities such as minting, burning, and transferring tokens, as well as transferring ownership of the contract. This program serves as a simple and straightforward introduction to Solidity programming and ERC20 token standards, and can be used as a stepping stone for more complex projects in the future.

Key functionalities implemented in this smart contract include:

- Ownership management: Functions for transferring ownership, ensuring only the contract owner can mint tokens or transfer ownership.
- Token minting: The contract owner can mint new tokens to a specified address.
- Token burning: Users can burn their tokens, reducing the total supply.
- Token transfer: Standard ERC20 token transfer and transferFrom functions with additional recipient validation.

## Getting Started

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix IDE](https://remix.ethereum.org/).

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `DeganToken.sol`). Copy and paste the following code into the file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeganToken is ERC20 {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() ERC20("Degan", "DGN")  {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "DeganToken: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "DeganToken: new owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(_validRecipient(recipient), "DeganToken: invalid recipient");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(_validRecipient(recipient), "DeganToken: invalid recipient");
        return super.transferFrom(sender, recipient, amount);
    }

    function _validRecipient(address to) private pure returns (bool) {
        return to != address(0);
    }
}



```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile DeganToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DeganToken" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the createProposal and vote functions. For example, you can create a new proposal by providing a description. Similarly, you can poll on a proposal by providing the proposal ID.

## Authors

Ayush sah
[@linkedin](https://www.linkedin.com/in/ayushsah404/)


## License

This project is licensed under the MIT License
