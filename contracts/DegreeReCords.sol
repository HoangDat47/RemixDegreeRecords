// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DegreeRecords {
    address owner;

    struct Degree {
        uint256 id;
        string studentName;
        string email;
        string issuer;
        string degreeName;
        string ifpsHash;
        string ifpsUrl;
        uint256 timestamp;
    }

    mapping(uint256 => Degree[]) private degreeRecords;
    mapping(address => bool) private authorizedProviders;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this function");
        _;
    }

    modifier onlyAuthorizedProvider() {
        require(authorizedProviders[msg.sender], "Not and authorized provider");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function authorizeProvider(address provider) public onlyOwner {
        authorizedProviders[provider] = true;
    }

    function addRecord(uint256 id,
        string memory studentName,
        string memory email,
        string memory issuer,
        string memory degreeName,
        string memory ifpsHash,
        string memory ifpsUrl) public onlyAuthorizedProvider {
            uint256 recordID = degreeRecords[id].length + 1;
            degreeRecords[id].push(Degree(recordID, studentName, email, issuer, degreeName, ifpsHash, ifpsUrl, block.timestamp));
        }

    function getDegreeRecords(uint256 id) public view onlyAuthorizedProvider returns (Degree[] memory) {
        return degreeRecords[id];
    }
}

///0xf2604e98d7c0f0f043f66cc099006645fb368b81