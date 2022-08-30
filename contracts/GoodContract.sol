 //SPDX-License-Identifier:MIT
 pragma solidity ^0.8.10;

 contract GoodContract{
    mapping(address=>uint) balances;

    // function to update the balance sent by the msg.sender 
    function addBalance() public payable{
        balances[msg.sender]+=msg.value;
    }


    // Send ETH worth `balances[msg.sender]` back to msg.sender
    function withdraw()public payable{
        require(balances[msg.sender]>0 ,"you do not have enough balance");
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent,"failed to send balances");

        // This code becomes unreachable because the contract's balance is drained
        // before user's balance could have been set to 0
        balances[msg.sender] = 0;

    }
 }