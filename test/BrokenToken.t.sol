// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {BrokenToken} from "../src/BrokenToken.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";

import {MockERC4626} from "solmate/test/utils/mocks/MockERC4626.sol";

contract BrokenTokenTest is Test, BrokenToken {
    address bob = makeAddr("bob");
    MockERC4626 vault;

    function testWeirdTokenDeposit() public useBrokenToken {
        vault = new MockERC4626(ERC20(address(brokenERC20)), brokenERC20_NAME, brokenERC20_NAME);
        deal(address(brokenERC20), bob, 1_000_000);

        vm.startPrank(bob);
        brokenERC20.approve(address(vault), 1_000_000);
        vault.deposit(100, bob);
        vm.stopPrank();
    }
}
