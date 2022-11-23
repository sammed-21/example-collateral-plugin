// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface stEthWrapper {
    function underlyingExchangeRate() external view returns (uint256);
}
