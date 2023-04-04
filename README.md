## Simple ERC20 Token Bridge Contract

- 블록체인 상에서 ERC20 토큰을 다른 블록체인으로 이전시키는 간단한 Bridge Contract 입니다.

## SampleToken.sol

- SampleToken은 ERC20 표준을 따르는 테스트용 토큰입니다.

## 구성 요소

### SampleToken.sol

- SampleToken 컨트랙트는 ERC20 컨트랙트에서 상속받은 이름, 심볼, 초기발행량 등을 설정하는 함수와 관리자에 한해 추가적으로 토큰을 발행하거나 소각하는 함수를 가지고 있습니다.

### ERC20.sol

- ERC20 컨트랙트는 ERC20 토큰 표준을 따르도록 구현된 토큰 컨트랙트입니다.

### ISampleToken.sol

- ISampleToken 인터페이스는 SampleToken 컨트랙트에서 구현된 함수들의 시그니처를 포함하고 있습니다.

## 주의 사항

- SampleToken의 ownerMint 및 ownerBurn 함수는 오직 관리자에게만 허용됩니다.
- 토큰 발행 시 총 발행량이 최대 발행량을 초과할 경우 오류가 발생합니다.

## Bridge.sol

- Bridge는 블록체인 상에서 ERC20 토큰을 다른 블록체인으로 이전시키는 컨트랙트 입니다.

## 구성 요소

### Admin.sol

- Bridge contract에서 사용되는 관리자 관련 함수가 구현된 라이브러리입니다.

- Bridge contract에서 관리자에 대한 접근 권한을 설정하고, 관리자만이 일부 함수를 실행할 수 있도록 합니다.

### Address.sol

- Address 타입의 데이터를 다루기 위한 함수들이 구현된 라이브러리입니다.

### ISampleToken.sol

- SampleToken contract에서 구현한 인터페이스입니다. SampleToken contract의 Public 함수들을 호출하기 위한 ABI를 정의합니다.

## 주요 기능

- bridgeAbleToken mapping : Bridge 가능한 ERC20 토큰 목록을 저장합니다.

- TokenSent / TokenReceive event : 토큰 전송 시 발생하는 이벤트 입니다.

- bridgeSent function : 특정 ERC20 토큰을 다른 블록체인으로 전송하는 함수입니다.

- bridgeReceive function : 다른 블록체인으로부터 특정 ERC20을 수신하는 함수입니다.

- addTokenAble function : Bridge 가능한 ERC20 토큰을 추가하는 함수입니다.

- removeTokenAble function : Bridge 가능한 ERC20 토큰을 제거하는 함수입니다.

## Bridge process ( Ethereum to BSC )

1. 사용자는 Ethereum 네트워크의 Bridge Contract에 브릿지 기능을 사용할 토큰 주소와 1000개의 토큰을 보냅니다.

2. Bridge Contract에서는 이를 확인하고 1000개 만큼의 토큰을 소각합니다.

3. Binance Smart Chain 네트워크의 Bridge Contract에서 해당 사용자에게 1000개의 토큰을 추가로 발행합니다.