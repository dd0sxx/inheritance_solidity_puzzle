// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "solmate/src/tokens/ERC721.sol";

contract SimpleTipNFT is ERC721 {
    address owner;


    constructor() ERC721("Simple Tip NFT", "ST") {
        owner = msg.sender;
    }

    function mint() public payable {
        uint256 _currentSupply = currentSupply;
        require(msg.value == 0.01 ether && _currentSupply < 10000);
        _mint(msg.sender, _currentSupply);
        unchecked {
            currentSupply++;
        }
    }

    function tokenURI(uint256 id)
        public
        view
        virtual
        override
        returns (string memory)
    {

    }

    function transferFrom (
        address from,
        address to,
        uint256 id
    ) public payable override {
        doSomething();
        super.transferFrom(from, to, id);
    }

    function safeTransferFrom (
        address from,
        address to,
        uint256 id
    ) public payable override {
        require(msg.value > 0, "INVALID_TIP");
        doSomething();
        super.safeTransferFrom(from, to, id);
    }

    function doSomething () internal {

    }

}
