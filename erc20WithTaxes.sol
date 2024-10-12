// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TaxableToken is ERC20, Ownable {

    uint256 public buyTax;
    uint256 public sellTax;
    address public taxRecipient;

    mapping(address => bool) public isExcludedFromTax;

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        taxRecipient = msg.sender;  // Default recipient is the owner
        isExcludedFromTax[msg.sender] = true;  // Exclude owner from tax
    }

    function setBuyTax(uint256 _buyTax) external onlyOwner {
        require(_buyTax <= 10, "Buy tax must be <= 10%");
        buyTax = _buyTax;
    }

    function setSellTax(uint256 _sellTax) external onlyOwner {
        require(_sellTax <= 10, "Sell tax must be <= 10%");
        sellTax = _sellTax;
    }

    function setTaxRecipient(address _recipient) external onlyOwner {
        taxRecipient = _recipient;
    }

    function excludeFromTax(address account, bool excluded) external onlyOwner {
        isExcludedFromTax[account] = excluded;
    }

    // Override transfer function to include tax logic
    function _transfer(address sender, address recipient, uint256 amount) internal override {
        uint256 taxAmount = 0;

        if (!isExcludedFromTax[sender] && !isExcludedFromTax[recipient]) {
            // Determine if the transaction is a buy or sell
            if (isUniswapSwap(sender)) {  // Replace with actual condition for detecting buy
                taxAmount = (amount * buyTax) / 100;
            } else if (isUniswapSwap(recipient)) {  // Replace with actual condition for detecting sell
                taxAmount = (amount * sellTax) / 100;
            }
        }

        uint256 amountAfterTax = amount - taxAmount;

        // Send tax to the recipient
        if (taxAmount > 0) {
            super._transfer(sender, taxRecipient, taxAmount);
        }

        // Execute the normal transfer
        super._transfer(sender, recipient, amountAfterTax);
    }

    // Mock function to check if sender is interacting with a DEX (replace with actual logic)
    function isUniswapSwap(address account) private pure returns (bool) {
        return false;  // Replace with actual condition based on the exchange
    }
}