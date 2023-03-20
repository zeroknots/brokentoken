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

abstract contract WeirdToken {
    IERC20 public weirdERC20;
    IERC20 public weirdERC20_2;
    IERC20 public normalERC20;


    address[] public weirdTokens;
    uint256 MAX_INT = type(uint256).max;

    modifier useWeirdToken() {
        for (uint256 i; i < weirdTokens.length; ++i) {
            weirdERC20 = IERC20(weirdTokens[i]);
            _;
        }
    }

    modifier useWeirdTokenPair() {
        for (uint256 i; i < weirdTokens.length; ++i) {
            for (uint256 y = i; y < weirdTokens.length; ++y) {
                weirdERC20 = IERC20(weirdTokens[i]);
                weirdERC20_2 = IERC20(weirdTokens[y]);
                _;
            }
        }
    }

    modifier useWeirdAndNormal() {
      normalERC20 = IERC20(address(new MockERC20("Normal", "NRM", 18)));
        for (uint256 i; i < weirdTokens.length; ++i) {
            weirdERC20 = IERC20(weirdTokens[i]);
            _;
        }
    }

    constructor() {
        weirdTokens.push(address(new ReturnsTwoToken()));
        weirdTokens.push(address(new RevertingToken()));
        weirdTokens.push(address(new ReturnsTooLittleToken()));
        weirdTokens.push(address(new ReturnsTooMuchToken()));
        weirdTokens.push(address(new ReturnsGarbageToken()));
        weirdTokens.push(address(new ApprovalRaceToken(MAX_INT)));
        weirdTokens.push(address(new ApprovalToZeroToken(MAX_INT)));
        weirdTokens.push(address(new BlockableToken(MAX_INT)));
        weirdTokens.push(address(new DaiPermit(MAX_INT)));
        weirdTokens.push(address(new HighDecimalToken(MAX_INT)));
        weirdTokens.push(address(new LowDecimalToken(MAX_INT)));
        weirdTokens.push(address(new MissingReturnToken(MAX_INT)));
        weirdTokens.push(address(new NoRevertToken(MAX_INT)));
        weirdTokens.push(address(new PausableToken(MAX_INT)));
        weirdTokens.push(address(new ProxiedToken(MAX_INT)));
        weirdTokens.push(address(new PausableToken(MAX_INT)));
        weirdTokens.push(address(new ReentrantToken(MAX_INT)));
        weirdTokens.push(address(new ReturnsFalseToken(MAX_INT)));
        weirdTokens.push(address(new RevertToZeroToken(MAX_INT)));
        weirdTokens.push(address(new RevertZeroToken(MAX_INT)));
        weirdTokens.push(address(new TransferFeeToken(1337, 1)));
        weirdTokens.push(address(new TransferFromSelfToken(MAX_INT)));
        weirdTokens.push(address(new Uint96ERC20(1337)));
        weirdTokens.push(address(new Proxy(MAX_INT)));
    }
}
