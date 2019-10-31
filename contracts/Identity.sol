pragma solidity ^0.5.4;

import "./ExecuteCall.sol";
import "./KeyData.sol";
import "./Metadata.sol";
import "@openzeppelin/upgrades/contracts/Initializable.sol";

//Mostly copied from https://github.com/ethereum/EIPs/blob/master/EIPS/eip-725.md
contract Identity is Initializable, ExecuteCall, KeyData, Metadata {
    event EthSent(address recipient, uint256 value);

    function() external payable {}

    function initialize(address _initialOwner) public initializer {
        WhitelistAdminRole.initialize(_initialOwner);
    }

    function sendEth(address payable _recipient, uint256 _valueInWei)
        external
        onlyWhitelistAdmin()
    {
        _recipient.transfer(_valueInWei);
        emit EthSent(_recipient, _valueInWei);
    }

}
