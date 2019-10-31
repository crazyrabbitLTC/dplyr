pragma solidity ^0.5.4;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistAdminRole.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistedRole.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/drafts/Counters.sol";

contract Metadata is WhitelistAdminRole, WhitelistedRole {
    using Counters for Counters.Counter;
    Counters.Counter public metadataCount;

    string[] public metadata;

    event metadataAdded(address identity, string metadata, uint256 index);

    function addIdMetadata(string calldata _metadata) external onlyWhitelistAdmin() {
        metadata.push(_metadata);
        emit metadataAdded(address(this), _metadata, metadataCount.current());
        metadataCount.increment();
    }

    function getTotalMetadata() public view returns (uint256) {
        return metadataCount.current();
    }

    function getSingleIdMetaData(uint256 _index) external returns (string memory item) {
        require(_index <= metadata.length, "Metadata record does not exist");
        return metadata[_index];
    }
}
