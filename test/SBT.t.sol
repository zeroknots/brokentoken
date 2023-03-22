// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {SBT721} from "../src/erc721/SBT721.sol";

contract SBTTest is Test {
    SBT721 sbt;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        sbt = new SBT721();
    }

    function testMint() public {
        sbt.mint(alice);
        assertEq(sbt.balanceOf(alice), 1);

        sbt.mint(alice);
        assertEq(sbt.balanceOf(alice), 2);

        vm.startPrank(alice);
        vm.expectRevert(SBT721.__SBT__NoTransferAllowed.selector);
        sbt.transferFrom(alice, bob, 1);
        vm.stopPrank();

    }
}
