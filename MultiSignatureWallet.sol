// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

contract MultisigWallet {

    address private _owner;
    mapping(address => uint8) private _owners;
    modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }

    modifier validOwner() {
        require(msg.sender == _owner || _owners[msg.sender] == 1);
        _;
    }
    
    event DepositFunds(address from, uint amount);
    event withdrawFunds(address to, uint amount);
    event transferFunds(address from, address to, uint amount);

    function MultiSigWallet()
        public {
            _owner = msg.sender;
        }

    function addOwner(address owner)
        isOwner
        public {
            _owners[owner] = 1;
        }

    function removeOwner(address owner)
        isOwner
        public {
        _owners[owner] = 0;
        }

    function Deposit()
        public
        payable {
            emit DepositFunds(msg.sender, msg.value);
        }

    function withdraw(uint amount)
        validOwner
        public {
            require(address(this).balance >= amount);
            msg.sender.transfer(amount);
            emit withdrawFunds(msg.sender, amount);
        }

    function transferTo(address to, uint amount)
        validOwner
        public {
            require(address(this).balance >= amount);
            msg.sender.transfer(amount);
            emit transferFunds(msg.sender, to, amount);

    }

}
