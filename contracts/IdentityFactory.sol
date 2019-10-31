pragma solidity ^0.5.4;

import "./Identity.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/drafts/Counters.sol";

contract IdentityFactory is Initializable, Context {
    using Counters for Counters.Counter;
    Counters.Counter public identityCount;

    bool public contractInitialized;

    mapping(uint256 => Identity) public identities;

    event identityCreated(
        address identityAddress,
        address owner,
        uint256 identityId,
        string metadata
    );
    event identityFactoryCreated(address factoryAddress);

    function initialize() public initializer {
        contractInitialized = true;
        emit identityFactoryCreated(address(this));
    }

    function createIdentity(address _initialOwner, string calldata _metadata) external {
        uint256 identityId = identityCount.current();
        Identity identity;
        identity = new Identity();
        identity.initialize(address(this));
        identity.addWhitelistAdmin(_initialOwner);
        identity.addIdMetadata(_metadata);
        identity.renounceWhitelistAdmin();
        identities[identityId] = identity;
        identityCount.increment();
        emit identityCreated(address(identity), _msgSender(), identityId, _metadata);
    }

}
