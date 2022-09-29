// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PFP is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("ProfilePicture", "PFP") {}

    function mint(address buyer, string memory tokenURI)
        public 
        onlyOwner
        returns (uint256)
    {
        uint256 newPFPId = _tokenIds.current();
        _mint(buyer, newPFPId);
        _setTokenURI(newPFPId, tokenURI);

        _tokenIds.increment();
        return newPFPId;
    }
}