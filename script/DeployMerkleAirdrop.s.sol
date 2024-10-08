// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    MerkleAirdrop public airdrop;
    BagelToken public token;

    bytes32 private MERKLE_ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private AMOUNT_TO_TRANSFER = 4 * 25 * 1e18;

  function deployMerkleAirdrop() public returns (MerkleAirdrop, BagelToken) {
        vm.startBroadcast();
        token = new BagelToken();
        airdrop = new MerkleAirdrop(MERKLE_ROOT, IERC20(address(token)));
        token.mint(token.owner(), AMOUNT_TO_TRANSFER);
        token.transfer(address(airdrop), AMOUNT_TO_TRANSFER);
        vm.stopBroadcast();

        return (airdrop, token);
    }

    function run() external returns (MerkleAirdrop, BagelToken) {
        return deployMerkleAirdrop();
    }
}
