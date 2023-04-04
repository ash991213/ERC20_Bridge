// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./extentions/Admin.sol";
import "./extentions/Address.sol";
import "./interface/ISampleToken.sol";

contract Bridge is Admin {
    using Address for address;

    mapping(address => bool) public bridgeAbleToken;

    event TokenSent(address, address, uint256);
    event TokenReceive(address, address, uint256);

    constructor(address _token) {
        bridgeAbleToken[_token] = true;
    }

    // Bridge Contract에 토큰을 소각합니다. 반대 브릿지에서 토큰을 공급받을 주소를 알 수 있도록 to address를 event로 출력합니다. 
    function bridgeSent(address _token, address _to, uint256 _amount) external returns(bool) {
        require(bridgeAbleToken[_token], "Bridge : This ERC20 token is that cannot be bridged.");

        ISampleToken token = ISampleToken(_token);
        token.ownerBurn(_msgSender(), _amount);
        emit TokenSent(_to, _token, _amount);

        return true;
    }

    // 유저에게 토큰을 추가 발행합니다.
    function bridgeReceive(address _token, address _to, uint256 _amount) external onlyAdmin returns(bool) {
        require(bridgeAbleToken[_token], "Bridge : This ERC20 token is that cannot be bridged.");

        ISampleToken token = ISampleToken(_token);
        token.ownerMint(_to, _amount);
        emit TokenReceive(_to, _token, _amount);

        return true;
    }

    // ERC20 토큰을 Bridge 가능하도록 추가합니다.
    function addTokenAble(address _token) external onlyAdmin returns(bool) {
        require(Address.isContract(_token), "Bridge : This address is not the contract address");
        bridgeAbleToken[_token] = true;
        return true;
    }

    // ERC20 토큰을 Bridge 불가능하도록 제거합니다.
    function removeTokenAble(address _token) external onlyAdmin returns(bool) {
        require(Address.isContract(_token), "Bridge : This address is not the contract address");
        bridgeAbleToken[_token] = false;
        return true;
    }
}