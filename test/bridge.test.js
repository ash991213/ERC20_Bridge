const Web3 = require('web3');
const web3 = new Web3();
const Bridge = artifacts.require('Bridge');
const SampleToken = artifacts.require('SampleToken');

function toEther(value) {
	return web3.utils.fromWei(value, 'ether');
}

function toWei(value) {
	return web3.utils.toWei(value, 'ether');
}

async function errException(promise) {
	try {
		await promise;
	} catch (error) {
		return error.reason;
	}
	assert.fail('Expected throw not received');
}

contract('Bridge', (accounts) => {
	const tokenAmount = 100;
	const [admin, user] = accounts;
	let bridge, token, beforeMaxSupply, updateMaxSupply;

	beforeEach(async () => {
		token = await SampleToken.new({ from: admin });
		bridge = await Bridge.new(token.address, { from: admin });
	});

	// * Bridge에 토큰 등록
	describe('addTokenAble', () => {
		it('[SUCCESS] SampleToken must be registered with the Bridge.', async () => {
			assert.isTrue(await bridge.bridgeAbleToken(token.address, { from: admin }));
		});
	});

	// * Bridge contract의 bridgeSent와 bridgeReceive 함수 테스트
	describe('bridgeSent & bridgeReceive', () => {
		beforeEach(async () => {
			beforeMaxSupply = await token.maxSupply();
			updateMaxSupply = toWei(toEther(beforeMaxSupply) + web3.utils.toBN(tokenAmount));
			await token.setMaxSupply(updateMaxSupply);
			await token.setAdmin(bridge.address);
		});

		it('[SUCCESS] should update sampleToken maxSupply', async () => {
			const afterMaxSupply = await token.maxSupply();
			assert.equal(toEther(afterMaxSupply), toEther(beforeMaxSupply) + web3.utils.toBN(tokenAmount));
		});

		it('[SUCCESS] should revert if token is not bridgeable', async () => {
			const sampleToken = await SampleToken.new();
			await errException(bridge.bridgeSent(sampleToken.address, user, tokenAmount, { from: admin }));
		});

		it('[SUCCESS] should issue additional tokens & burn them', async () => {
			await token.transfer(user, tokenAmount, { from: admin });

			const sentTx = await bridge.bridgeSent(token.address, user, tokenAmount, { from: user });

			assert.equal(sentTx.logs[0].event, 'TokenSent');
			assert.equal(sentTx.logs[0].args[0], user);
			assert.equal(sentTx.logs[0].args[1], token.address);
			assert.equal(sentTx.logs[0].args[2], tokenAmount);

			const receiveTx = await bridge.bridgeReceive(token.address, user, tokenAmount, { from: admin });

			assert.equal(receiveTx.logs[0].event, 'TokenReceive');
			assert.equal(receiveTx.logs[0].args[0], user);
			assert.equal(receiveTx.logs[0].args[1], token.address);
			assert.equal(receiveTx.logs[0].args[2], tokenAmount);

			const receiveBalance = await token.balanceOf(user);
			assert.equal(receiveBalance, tokenAmount);
		});
	});

	// * Bridge에 토큰 등록 삭제
	describe('removeTokenAble', () => {
		it('[SUCCESS] SampleToken must be removed with the Bridge.', async () => {
			await bridge.removeTokenAble(token.address, { from: admin });
			assert.isFalse(await bridge.bridgeAbleToken(token.address));
		});
	});
});
