// Determine Solidity Version
pragma solidity ^0.7.0;

// Import Dependencies 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/access/Ownable.sol";

// Set contract to ERC721 for Non-Fungible Tokens
contract NftExample is ERC721, Ownable {

    // Initialize counter for contract
    using Counters for Counters.Counter;

    // Assign counter to variable token ID's
    Counters.Counter private _tokenIds;

    // Create unique identifier based off hash value
    mapping(string => uint8) hashes;

    // Construct NFT using eRC721 protocol
    constructor() ERC721("NFT-Example", "NEX") {}

    // Create a function to mint the NFT's
    function mintNft(address receiver, string memory tokenURI) external onlyOwner returns (uint256) {

        // Ensure NFT based on the provided token URI has not previously been created 
        require (hashes[tokenURI] != 1);

        // Increments the counter to one to prevent a second NFT from being minted
        hashes[tokenURI] = 1;

        // # Increment the counter 
        _tokenIds.increment();

        // Assign Token ID's 
        uint256 newNftTokenId = _tokenIds.current();

        // Mint tokens 
        _mint(receiver, newNftTokenId);

        // Set token URI 
        _setTokenURI(newNftTokenId, tokenURI);

        // Return token ID 
        return newNftTokenId;
    }
    
}
