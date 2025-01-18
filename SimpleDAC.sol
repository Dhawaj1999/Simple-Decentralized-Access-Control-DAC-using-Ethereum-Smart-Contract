pragma solidity ^0.8.0;

contract SimpleDAC {
    address public owner;
    string public secretFile;
    mapping(address => bool) public authorizedUsers;

    constructor(string memory _initialSecretFile) {
        owner = msg.sender;
        secretFile = _initialSecretFile;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function grantAccess(address _user) public onlyOwner {
        authorizedUsers[_user] = true;
    }

    function revokeAccess(address _user) public onlyOwner {
        authorizedUsers[_user] = false;
    }

    function getSecretFile() public view returns (string memory) {
        require(authorizedUsers[msg.sender] || msg.sender == owner, "Access denied");
        return secretFile;
    }
}