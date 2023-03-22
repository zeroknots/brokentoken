pragma solidity >=0.8.0;
import "solmate/tokens/ERC721.sol";


contract SBT721 is ERC721 {
    constructor() ERC721("SBT721", "SBT721") {}

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        return "https://www.sbt721.com";
    }
}
