// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface ISampleToken {
    function setMaxSupply(uint amount) external returns(bool);
    function ownerMint(address to, uint amount) external returns(bool);
    function ownerBurn(address from, uint amount) external returns(bool);
    function addTokenAble(address _token) external returns(bool);
    function removeTokenAble(address _token) external returns(bool);
}