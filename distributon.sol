// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/math/SafeMath.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}

// File: bepro-js/contracts/utils/Ownable.sol

pragma solidity >=0.6.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */
    constructor() public {
        owner = msg.sender;
    }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

// File: bepro-js/contracts/ERC20Distribution.sol

pragma solidity >=0.6.0;





/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Ownable {
    event Pause();
    event Unpause();

    bool public paused = false;


    /**
    * @dev Modifier to make a function callable only when the contract is not paused.
    */
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /**
    * @dev Modifier to make a function callable only when the contract is paused.
    */
    modifier whenPaused() {
        require(paused);
        _;
    }

    /**
    * @dev called by the owner to pause, triggers stopped state
    */
    function pause() onlyOwner whenNotPaused public {
        paused = true;
        emit Pause();
    }

    /**
    * @dev called by the owner to unpause, returns to normal state
    */
    function unpause() onlyOwner whenPaused public {
        paused = false;
        emit Unpause();
    }
}

contract ERC20Distribution is Pausable {
    using SafeMath for uint256;

    uint256 constant public decimals = 1 ether;
    address[] public tokenOwners ; /* Tracks distributions mapping (iterable) */
    uint256 public TGEDate = 0; /* Date From where the distribution starts (TGE) */
    uint256 constant public month = 30 days;
    uint256 constant public year = 365 days;
    uint256 public lastDateDistribution = 0;
    
    mapping(address => DistributionStep[]) public distributions; /* Distribution object */
    
    IERC20 public erc20;

    struct DistributionStep {
        uint256 amountAllocated;
        uint256 currentAllocated;
        uint256 unlockDay;
        uint256 amountSent;
    }

    constructor() public{
        
        // ICO
        setInitialDistribution(0x0000000000000000000000000000000000000IC0, 640000000, 0 /* No Lock */);

        /* Team */
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 6*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 7*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 8*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 9*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 10*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 11*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 12*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 13*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 14*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 15*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333333, 16*month);
        setInitialDistribution(0x000000000000000000000000000000000000tEaM, 133333337, 17*month);
        

        /* Something Else */
        setInitialDistribution(0x0000000000000000000000000000000000000000, 352000000, 0 /* No Lock */);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 3*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 4*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 5*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 6*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 7*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 8*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 9*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444444, 10*month);
        setInitialDistribution(0x0000000000000000000000000000000000000000, 156444448, 11*month);

        /* Treasury */
        setInitialDistribution(0x0000000000000000000000000000000000000g0lD, 320000000, 0 /* No Lock */);
        setInitialDistribution(0x0000000000000000000000000000000000000g0lD, 320000000, 6*month);
        setInitialDistribution(0x0000000000000000000000000000000000000g0lD, 320000000, 12*month);
        setInitialDistribution(0x0000000000000000000000000000000000000g0lD, 1120000000, 18*month);
        setInitialDistribution(0x0000000000000000000000000000000000000g0lD, 1120000000, 24*month);

        /* Liquidity */
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 320000000, 0 /* No Lock */);
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 320000000, 3*month);
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 640000000, 6*month);
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 640000000, 9*month);
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 640000000, 12*month);
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 320000000, 18*month);
        setInitialDistribution(0x0000000000000000000000000000000000000L1qU, 320000000, 24*month);

    }

    function setTokenAddress(IERC20 _tokenAddress) external onlyOwner whenNotPaused  {
        erc20 = _tokenAddress;
    }
    
    function safeGuardAllTokens(address _address) external onlyOwner whenPaused  { /* In case of needed urgency for the sake of contract bug */
        require(erc20.transfer(_address, erc20.balanceOf(address(this))));
    }

    function setTGEDate(uint256 _time) external onlyOwner whenNotPaused  {
        TGEDate = _time;
    }

    /**
    *   Should allow any address to trigger it, but since the calls are atomic it should do only once per day
     */

    function triggerTokenSend() external whenNotPaused  {
        /* Require TGE Date already been set */
        require(TGEDate != 0, "TGE date not set yet");
        /* TGE has not started */
        require(block.timestamp > TGEDate, "TGE still hasn´t started");
        /* Test that the call be only done once per day */
        require(block.timestamp.sub(lastDateDistribution) > 1 days, "Can only be called once a day");
        lastDateDistribution = block.timestamp;
        /* Go thru all tokenOwners */
        for(uint i = 0; i < tokenOwners.length; i++) {
            /* Get Address Distribution */
            DistributionStep[] memory d = distributions[tokenOwners[i]];
            /* Go thru all distributions array */
            for(uint j = 0; j < d.length; j++){
                if( (block.timestamp.sub(TGEDate) > d[j].unlockDay) /* Verify if unlockDay has passed */
                    && (d[j].currentAllocated > 0) /* Verify if currentAllocated > 0, so that address has tokens to be sent still */
                ){
                    uint256 sendingAmount;
                    sendingAmount = d[j].currentAllocated;
                    distributions[tokenOwners[i]][j].currentAllocated = distributions[tokenOwners[i]][j].currentAllocated.sub(sendingAmount);
                    distributions[tokenOwners[i]][j].amountSent = distributions[tokenOwners[i]][j].amountSent.add(sendingAmount);
                    require(erc20.transfer(tokenOwners[i], sendingAmount));
                }
            }
        }   
    }

    function setInitialDistribution(address _address, uint256 _tokenAmount, uint256 _unlockDays) internal onlyOwner whenNotPaused {
        /* Add tokenOwner to Eachable Mapping */
        bool isAddressPresent = false;

        /* Verify if tokenOwner was already added */
        for(uint i = 0; i < tokenOwners.length; i++) {
            if(tokenOwners[i] == _address){
                isAddressPresent = true;
            }
        }
        /* Create DistributionStep Object */
        DistributionStep memory distributionStep = DistributionStep(_tokenAmount * decimals, _tokenAmount * decimals, _unlockDays, 0);
        /* Attach */
        distributions[_address].push(distributionStep);

        /* If Address not present in array of iterable token owners */
        if(!isAddressPresent){
            tokenOwners.push(_address);
        }
    }
}