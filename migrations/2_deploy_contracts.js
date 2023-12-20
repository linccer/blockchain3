var Main = artifacts.require("sushiOrder");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Main, accounts[1]);
};
