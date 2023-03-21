// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";

/*           NORMAL TOKENS             */
import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

/*           solmate WEIRD TOKENS             */
import {ReturnsTwoToken} from "solmate/test/utils/weird-tokens/ReturnsTwoToken.sol";
import {RevertingToken} from "solmate/test/utils/weird-tokens/RevertingToken.sol";
import {ReturnsTooLittleToken} from "solmate/test/utils/weird-tokens/ReturnsTooLittleToken.sol";
import {ReturnsTooMuchToken} from "solmate/test/utils/weird-tokens/ReturnsTooMuchToken.sol";
import {ReturnsGarbageToken} from "solmate/test/utils/weird-tokens/ReturnsGarbageToken.sol";

/*           d-xo/weird-erc20 WEIRD TOKENS             */
import {ApprovalRaceToken} from "weird-erc20/Approval.sol";
import {ApprovalToZeroToken} from "weird-erc20/ApprovalToZero.sol";
import {BlockableToken} from "weird-erc20/BlockList.sol";
import {DaiPermit} from "weird-erc20/DaiPermit.sol";
import {HighDecimalToken} from "weird-erc20/HighDecimals.sol";
import {LowDecimalToken} from "weird-erc20/LowDecimals.sol";
import {MissingReturnToken} from "weird-erc20/MissingReturns.sol";
import {NoRevertToken} from "weird-erc20/NoRevert.sol";
import {PausableToken} from "weird-erc20/Pausable.sol";
import {ProxiedToken} from "weird-erc20/Proxied.sol";
import {PausableToken} from "weird-erc20/Pausable.sol";
import {ReentrantToken} from "weird-erc20/Reentrant.sol";
import {ReturnsFalseToken} from "weird-erc20/ReturnsFalse.sol";
import {RevertToZeroToken} from "weird-erc20/RevertToZero.sol";
import {RevertZeroToken} from "weird-erc20/RevertZero.sol";
import {TransferFeeToken} from "weird-erc20/TransferFee.sol";
import {TransferFromSelfToken} from "weird-erc20/TransferFromSelf.sol";
import {Uint96ERC20} from "weird-erc20/Uint96.sol";
import {Proxy} from "weird-erc20/Upgradable.sol";

import "forge-std/Test.sol";

struct TokenInfo {
    address addr;
    string name;
}

abstract contract WeirdToken is Test {
    uint256 MAX_INT = type(uint256).max;


    IERC20 public weirdERC20;
    string public weirdERC20_NAME;

    IERC20 public weirdERC20_2;
    string public weirdERC20_2_NAME;
    IERC20 public normalERC20;


    // address[] public weirdTokens;

    TokenInfo[] public weirdTokens;

    modifier useWeirdToken() {
        for (uint256 i; i < weirdTokens.length; ++i) {
            weirdERC20 = IERC20(weirdTokens[i].addr);
            weirdERC20_NAME = weirdTokens[i].name;
            _;
        }
    }

    modifier useWeirdTokenPair() {
        for (uint256 i; i < weirdTokens.length; ++i) {
            for (uint256 y = i; y < weirdTokens.length; ++y) {
                weirdERC20 = IERC20(weirdTokens[i].addr);
                weirdERC20_NAME = weirdTokens[i].name;
                weirdERC20_2 = IERC20(weirdTokens[y].addr);
                weirdERC20_2_NAME = weirdTokens[y].name;

                _;
            }
        }
    }

    modifier useWeirdAndNormal() {
        normalERC20 = IERC20(address(new MockERC20("Normal", "NRM", 18)));
        for (uint256 i; i < weirdTokens.length; ++i) {
            weirdERC20 = IERC20(weirdTokens[i].addr);
            _;
        }
    }

    constructor() {
        weirdTokens.push(TokenInfo(address(new MockERC20("Normal", "NRM", 18)), "Vanilla ERC20"));
        // weirdTokens.push(address(new ReturnsTwoToken()));
        // weirdTokens.push(address(new RevertingToken()));
        // weirdTokens.push(address(new ReturnsTooLittleToken()));
        // weirdTokens.push(address(new ReturnsTooMuchToken()));
        // weirdTokens.push(address(new ReturnsGarbageToken()));
        weirdTokens.push(TokenInfo(address(new ApprovalRaceToken(MAX_INT)), "ApprovalRaceToken"));
        weirdTokens.push(TokenInfo(address(new ApprovalToZeroToken(MAX_INT)), "ApprovalToZeroToken"));
        weirdTokens.push(TokenInfo(address(new BlockableToken(MAX_INT)), "BlockableToken"));
        weirdTokens.push(TokenInfo(address(new DaiPermit(MAX_INT)), "DaiPermit"));
        weirdTokens.push(TokenInfo(address(new HighDecimalToken(MAX_INT)), "HighDecimalToken"));
        weirdTokens.push(TokenInfo(address(new LowDecimalToken(MAX_INT)), "LowDecimalToken"));
        weirdTokens.push(TokenInfo(address(new MissingReturnToken(MAX_INT)), "MissingReturnToken"));

        weirdTokens.push(TokenInfo(address(new NoRevertToken(MAX_INT)), "NoRevertToken"));
        weirdTokens.push(TokenInfo(address(new PausableToken(MAX_INT)), "PausableToken"));
        weirdTokens.push(TokenInfo(address(new ProxiedToken(MAX_INT)), "ProxiedToken"));
        weirdTokens.push(TokenInfo(address(new PausableToken(MAX_INT)), "PausableToken"));
        weirdTokens.push(TokenInfo(address(new ReentrantToken(MAX_INT)), "ReentrantToken"));
        weirdTokens.push(TokenInfo(address(new ReturnsFalseToken(MAX_INT)), "ReturnsFalseToken"));
        weirdTokens.push(TokenInfo(address(new RevertToZeroToken(MAX_INT)), "RevertToZeroToken"));
        weirdTokens.push(TokenInfo(address(new RevertZeroToken(MAX_INT)), "RevertZeroToken"));
        weirdTokens.push(TokenInfo(address(new TransferFeeToken(1337, 1)), "TransferFeeToken"));
        weirdTokens.push(TokenInfo(address(new TransferFromSelfToken(MAX_INT)), "TransferFromSelfToken"));
        weirdTokens.push(TokenInfo(address(new Uint96ERC20(1337)), "Uint96ERC20"));
        weirdTokens.push(TokenInfo(address(new Proxy(MAX_INT)), "Proxy"));


        // create labels for weird tokens. Helps debugging
        for(uint256 i; i < weirdTokens.length; ++i) {
            vm.label(weirdTokens[i].addr, weirdTokens[i].name);
        }
    }
}
