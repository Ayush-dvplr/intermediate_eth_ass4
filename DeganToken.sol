// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeganToken is ERC20 {
    address public owner;
    uint256 public nextTokenId;
    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => address) private _owners;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event ItemRedeemed(address indexed redeemer, uint256 indexed tokenId, string tokenURI);

    constructor() ERC20("Degan", "DGN") {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "DeganToken: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "DeganToken: new owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(_validRecipient(recipient), "DeganToken: invalid recipient");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(_validRecipient(recipient), "DeganToken: invalid recipient");
        return super.transferFrom(sender, recipient, amount);
    }

    function redeemItem(string memory tokenURI) public {
        uint256 tokenId = nextTokenId;
        _owners[tokenId] = msg.sender;
        _tokenURIs[tokenId] = tokenURI;
        emit ItemRedeemed(msg.sender, tokenId, tokenURI);
        nextTokenId++;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "DeganToken: token does not exist");
        return _tokenURIs[tokenId];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address tokenOwner = _owners[tokenId];
        require(tokenOwner != address(0), "DeganToken: token does not exist");
        return tokenOwner;
    }

    function _validRecipient(address to) private pure returns (bool) {
        return to != address(0);
    }
}
