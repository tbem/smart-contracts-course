// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract TaxableToken is IERC20, Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    uint256 public buyTax;
    uint256 public sellTax;
    address public taxRecipient;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => bool) public isExcludedFromTax;

    // Example: Array of DEX router addresses
    address[] private dexRouters = [
        0x5C69bEe701ef814a2B6a3EDD4B4bF56d1182c1D7, // UniswapV2 router
        0x111111111117dC0aa78b770fA6A738034120C302, // 1inch router
        0x053B3c6B2B6F831A428D53B5C1d9b0D317deFEb9, // Sushiswap router (for example)
        // Add other DEX routers as needed
    ];

  

    constructor(string memory name_, string memory symbol_, uint256 initialSupply) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 18;
        _totalSupply = initialSupply * (10 ** uint256(_decimals));
        _balances[msg.sender] = _totalSupply;

        taxRecipient = msg.sender; // Default recipient is the owner
        isExcludedFromTax[msg.sender] = true;  // Exclude owner from tax

        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
        return true;
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
    function _transfer(address sender, address recipient, uint256 amount) internal {
        uint256 taxAmount = 0;

        if (!isExcludedFromTax[sender] && !isExcludedFromTax[recipient]) {
            // Determine if the transaction is a buy or sell
            if (isDEXSwap(sender)) {  // Replace with actual condition for detecting buy
                taxAmount = (amount * buyTax) / 100;
            } else if (isDEXSwap(recipient)) {  // Replace with actual condition for detecting sell
                taxAmount = (amount * sellTax) / 100;
            }
        }

        uint256 amountAfterTax = amount - taxAmount;

        // Send tax to the recipient
        if (taxAmount > 0) {
            _balances[sender] -= taxAmount;
            _balances[taxRecipient] += taxAmount;
            emit Transfer(sender, taxRecipient, taxAmount);
        }

        // Execute the normal transfer
        _balances[sender] -= amount;
        _balances[recipient] += amountAfterTax;
        emit Transfer(sender, recipient, amountAfterTax);
    }

      // This function checks if the account is interacting with a DEX router
    function isDEXSwap(address account) private view returns (bool) {
        for (uint i = 0; i < dexRouters.length; i++) {
            if (account == dexRouters[i]) {
                return true; // The account is interacting with one of the DEX routers
            }
        }
        return false; // The account is not part of a swap on the known DEX routers
    }
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}