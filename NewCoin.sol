// SPDX-License-Indentifier: Unlicensed

pragma solidity ^0.8.7;

contract NewCoin {
    address public minter;
    mapping(address => uint) public balances;

    // Event allow clients to react to specific
    // contract changes you declear
    event Sent(address from, address to, uint amount);

    // Run when contract is created
    constructor() {
        minter = msg.sender;
    }

    // send an amount to a newly created coin to be an address
    // can only be called by the contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    // sends an amount of exiting coins
    // from any caller to an address
    function send(address receiver, uint amount) public{
        if(amount > balances[msg.sender]) {
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver,amount);
    }
}