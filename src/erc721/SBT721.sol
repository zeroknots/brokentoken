pragma solidity >=0.8.0;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract SBT721 is ERC721 {
    address immutable ADDRESS_ZERO = address(0);
    uint256 tokenCnt;

    bool blockTransfers = true;

    error __SBT__NoTransferAllowed();

    constructor() ERC721("SBT721", "SBT721") {}

    function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize)
        internal
        virtual
        override
    {
        if (from != ADDRESS_ZERO && blockTransfers) revert __SBT__NoTransferAllowed();
    }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }

    function toggleBlockTransfer() external {
        blockTransfers = !blockTransfers;
    }

    function mint(address to) public {
        ++tokenCnt;
        mint(to, tokenCnt);
    }

}
