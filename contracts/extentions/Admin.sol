// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Ownable.sol";

contract Admin is Ownable {
    mapping(address => bool) admin;

    constructor() {
        admin[_msgSender()] = true;
    }

    event AdminRegistration(address indexed _admin);
    event AdminDismissal(address indexed _admin);

    modifier onlyAdmin {
        require(admin[_msgSender()], "Admin : Only admin can execute this function");
        _;
    }

    function isAdmin(address _address) public view returns(bool) {
        return admin[_address];
    }

    function setAdmin(address _admin) external onlyOwner returns(bool) {
        admin[_admin] = true;
        emit AdminRegistration(_admin);
        return true;
    }

    function removeAdmin(address _admin) external onlyOwner returns(bool) {
        admin[_admin] = false;
        emit AdminDismissal(_admin);
        return true;
    }
}