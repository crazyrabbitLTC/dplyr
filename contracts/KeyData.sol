pragma solidity ^0.5.4;

import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistAdminRole.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistedRole.sol";

contract KeyData is WhitelistAdminRole, WhitelistedRole {
    mapping(bytes32 => bytes) store;

    event DataChanged(bytes32 indexed key, bytes value);

    function getData(bytes32 _key) external view returns (bytes memory _value) {
        return store[_key];
    }

    function setData(bytes32 _key, bytes calldata _value) external onlyWhitelistAdmin() {
        store[_key] = _value;
        emit DataChanged(_key, _value);
    }

}
