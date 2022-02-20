pragma solidity ^0.8.0;
import "hardhat/console.sol";
interface  Token{
	
	function balanceOf(address _owner)  external view returns(uint256 balance);
	function transfer (address _to ,uint256 _value) external returns(bool success);
	function transferFrom(address _from ,address _to ,uint256 _value) external returns(bool success);
	function approve (address _spender ,uint256 _value) external returns (bool success);
	function allowance (address _owner,address _spender) external view returns (uint256 remaining);

	event Transfer(address indexed _from ,address indexed _to ,uint256 _value);
	event Approval(address indexed _owner, address indexed _spender ,uint256 _value);
}

contract TokenDemo is Token{
	string public name;
	uint256 public totalSupply;
	uint8 public decimals;
	string public symbol;
    mapping(address=>uint256) balances;
    mapping(address=>mapping(address => uint256)) allowed;

	constructor (uint256 _initAmount , string memory _tokenName,uint8 _decimal, string memory _tokenSymbol){
        console.log( _initAmount);
         console.log( _tokenName);
          console.log( _decimal);
            console.log( _tokenSymbol);
		totalSupply = _initAmount;
		balances[msg.sender] = totalSupply;

		name = _tokenName;
		decimals = _decimal;
		symbol = _tokenSymbol;
	}

	function transfer(address _to ,uint256 _value)override  public returns (bool success){
		require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);

		balances[msg.sender] -= _value;
		balances[_to] +=_value;
		emit Transfer(msg.sender, _to,_value);
		return true;
	}
	function balanceOf(address _owner)override  public view returns  (uint256 balance) {
        return balances[_owner];
    }
    function transferFrom(address _from, address _to ,uint256 _value) override  public returns (bool success){
    	require(balances[_from] >= _value && allowed[_from][msg.sender]>= _value);
    	balances[_to] += _value;
    	balances[_from] -= _value;
    	allowed[_from][msg.sender] -= _value;
    	return true;
    }

    function approve(address _spender ,uint256 _value) override  public returns (bool success){
    	allowed[msg.sender][_spender] = _value;
    	emit Approval(msg.sender,_spender,_value);
    	return true;
    }

    function allowance (address tokenOwner, address spender) override  public view returns(uint256 remaining){
    	return allowed[tokenOwner][spender];
    }




}