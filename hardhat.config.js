/** @format */

require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();
// require("@nomiclabs/hardhat-waffle")
console.log(process.env.PRIVATE_KEY)

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
	solidity: "0.8.7",
	networks: {
		alphachain: {
			url: "https://rpc.all.co.tz/",
			chainId:19611009,
			accounts: [process.env.PRIVATE_KEY],
		},

		 
	},
  namedAccounts: {
    deployer: {
        default: 0,
        1: 0,   },
  }
};
