const SampleToken_Contract = artifacts.require('SampleToken');

module.exports = (deployer) => {
	deployer.deploy(SampleToken_Contract);
};
