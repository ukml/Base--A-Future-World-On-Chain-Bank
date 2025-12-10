// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title BankVault – Simple deposit vault (testnet example)
 * @author ukml – beginner builder on Base
 * @notice Conceptual sample only – unaudited, use on testnet first
 */
contract BankVault {
    mapping(address => uint256) public balances;
    IERC20 public usdc;

    constructor() {
        usdc = IERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913); // USDC on Base mainnet
    }

    function deposit(uint256 amount) external {
        require(usdc.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        require(usdc.transfer(msg.sender, amount), "Transfer failed");
    }
}
