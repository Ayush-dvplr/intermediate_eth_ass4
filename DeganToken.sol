// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DeganToken is ERC20 {
    address public owner;
    address public storeAddress;
    
    mapping(string => uint256) private redemptionCodes;

    constructor() ERC20("DeganToken", "DGT") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function setStoreAddress(address _storeAddress) external onlyOwner {
        storeAddress = _storeAddress;
    }

function generateRedemptionCode(uint256 amount) external onlyOwner returns (string memory) {
    string memory code = _generateRandomString();
    redemptionCodes[code] = amount;
    _mint(owner, amount); // Mint new tokens
    return code;
}


    function redeem(uint256 amount, string memory code) external {
        require(storeAddress != address(0), "Store address not set");
        require(redemptionCodes[code] >= amount, "Invalid or insufficient redemption code");

        redemptionCodes[code] -= amount;
        if (redemptionCodes[code] == 0) {
            delete redemptionCodes[code];
        }
        
        _transfer(storeAddress, msg.sender, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function _generateRandomString() private view returns (string memory) {
        uint256 random = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        return Strings.toHexString(random);
    }
}
