pragma solidity 0.8.19;

contract wallet1 {
    struct fdata {
        uint money;
        uint numpayments;    
    }
    mapping (address => fdata) Wallet;
    function get_numpayments(address _from) public view returns(uint) {
        return(Wallet[_from].numpayments);
    }
    function get_money(address _from) public view returns(uint) {
        return(Wallet[_from].money);
    }
    function get_totalmoney() public view returns(uint) {
        return(address(this).balance);
    }
    receive() external payable {
        Wallet[msg.sender].money += msg.value;
        Wallet[msg.sender].numpayments += 1;
    }
    function draw_money(address payable _to, uint _amount) public {
        if (_amount <= Wallet[_to].money) {
            _to.transfer(_amount);
            Wallet[_to].money -= _amount;
        }
    }
    function drawall_money(address payable _to) public {
        _to.transfer(Wallet[_to].money);
        Wallet[_to].money = 0;
    }
    function pay_contract(address _to, uint _amount) public {
        if (_amount <= Wallet[msg.sender].money) {
            Wallet[_to].money += _amount;
            Wallet[msg.sender].money -= _amount;
        }
    }
    function pay_external(address payable _to, uint _amount) public {
         if (_amount <= Wallet[msg.sender].money) {
            _to.transfer(_amount);
            Wallet[msg.sender].money -= _amount;
        }
    }
    function pay_all_external(address payable _to) public {
        _to.transfer(Wallet[msg.sender].money);
        Wallet[msg.sender].money = 0;
    }
}