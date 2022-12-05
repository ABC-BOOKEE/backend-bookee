// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract bookMint is ERC721URIStorage {
    uint256 private tokenCounter;

    constructor() ERC721("book", "BK") {
        tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) external return (uint256){
        tokenCounter ++;
        _safeMint(msg.sender, tokenCounter);
        _setTokenURI (tokenCounter,tokenUri)

        return tokenCounter;
    }
 

    function getTokenCounter() public view returns (uint256) {
        return tokenCounter;
    }
}