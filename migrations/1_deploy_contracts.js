var JobPortal = artifacts.require("JobPortal");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(JobPortal);
};