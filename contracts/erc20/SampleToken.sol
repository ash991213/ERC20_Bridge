// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";
import "../interface/ISampleToken.sol";

contract SampleToken is ERC20 {
    uint _maxSupply;

    constructor() ERC20("TestToken","TT") {
        _maxSupply = 10000 ether;
        super._mint(_msgSender(), 10000 ether);
    }

    function maxSupply() public view returns(uint) {
        return _maxSupply;
    }

    function setMaxSupply(uint amount) external onlyAdmin returns(bool) {
        _maxSupply = amount;
        return true;
    }

    // 관리자에 한해서 토큰을 추가 발행합니다.
    function ownerMint(address to, uint amount) external onlyAdmin returns(bool) {
        require(totalSupply() + amount <= maxSupply(), 'SampleToken : Issue amount cannot exceed the maximum issue amount');
        
        _mint(to, amount);
        emit Transfer(address(0), to, amount);
        return true;
    }

    // 관리자에 한해서 토큰을 소각합니다.
    function ownerBurn(address from, uint amount) external returns(bool) {
        _burn(from, amount);
        emit Burn(from, amount);
        return true;
    }
}