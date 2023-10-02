//SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;

contract testTokens {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier trueOwner() {
        require(msg.sender == owner, "Only owner can move further");
        _;
    }
    modifier isPaused() {
        require(paused == false, "Sorry the contract is paused");
        _;
    }

    function pause() public trueOwner {
        paused = true;
    }

    function unpause() public trueOwner {
        paused = false;
    }

    function transfer(address to, uint amount) public isPaused {
        require(balances[msg.sender] >= amount, "Hy your balance is low");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
//a basic example of modifier