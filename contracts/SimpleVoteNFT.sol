// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "solmate/src/tokens/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleVoteNFT is ERC721, Ownable {

    uint256 currentSupply;
    mapping (address => uint256) votingPower; // 1 NFT = 1 vote

    constructor() ERC721("Simple Vote NFT", "SV") {}

    function mint() public payable {
        uint256 _currentSupply = currentSupply;
        require(msg.value > 0.01 ether && _currentSupply < 10000);
        _mint(msg.sender, _currentSupply);
        unchecked {
            currentSupply++;// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "solmate/src/tokens/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleVoteNFT is ERC721, Ownable {

    uint256 currentSupply;
    mapping (address => uint256) votingPower; // 1 NFT = 1 vote

    constructor() ERC721("Simple Vote NFT", "SV") {}

    function mint() public payable {
        uint256 _currentSupply = currentSupply;
        require(msg.value > 0.01 ether && _currentSupply < 10000);
        _mint(msg.sender, _currentSupply);
        unchecked {
            currentSupply++;
            votingPower[msg.sender]++;
        }
    }

    function transferFrom (
        address from,
        address to,
        uint256 id
    ) public override {
        transferVotingPower(from, to);
        super.transferFrom(from, to, id);
    }

    function safeTransferFrom (
        address from,
        address to,
        uint256 id
    ) public override {
        transferVotingPower(from, to);
        super.safeTransferFrom(from, to, id);
    }

    function transferVotingPower (address from, address to) internal {
        unchecked {
            votingPower[from]--;
            votingPower[to]++;
        }
    }

    function withdraw () external onlyOwner {
        (bool success, bytes memory response) = owner().call{value: address(this).balance}("");
        require(success);
    }

    function tokenURI(uint256 id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return string(abi.encodePacked("ipfs://deadbeef/", id));
    }

    receive () external payable {

    }



}

            votingPower[msg.sender]++;
        }
    }

    function transferFrom (
        address from,
        address to,
        uint256 id
    ) public override {
        transferVotingPower(from, to);
        super.transferFrom(from, to, id);
    }

    function safeTransferFrom (
        address from,
        address to,
        uint256 id
    ) public override {
        transferVotingPower(from, to);
        super.safeTransferFrom(from, to, id);
    }

    function transferVotingPower (address from, address to) internal {
        unchecked {
            votingPower[from]--;
            votingPower[to]++;
        }
    }

    function withdraw () external onlyOwner {
        (bool success, bytes memory response) = owner().call{value: address(this).balance}("");
        require(success);
    }

    function tokenURI(uint256 id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return string(abi.encodePacked("ipfs://deadbeef/", id));
    }

    receive () external payable {

    }



}
