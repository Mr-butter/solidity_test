const fs = require("fs");
const HDWalletProvider = require("@truffle/hdwallet-provider");

//Account credentials from which our contract will be deployed
const PRIVATEKEY = fs.readFileSync("./.PRIVATEKEY").toString();

//API key of your Datahub account for Avalanche Fuji test network
const APIKEY = fs.readFileSync("./.APIKEY").toString();
const path = require("path");

module.exports = {
    // See <http://truffleframework.com/docs/advanced/configuration>
    // to customize your Truffle configuration!
    contracts_build_directory: path.join(__dirname, "client/src/contracts"),
    networks: {
        develop: {
            host: "127.0.0.1",
            port: 7545,
            network_id: "5777",
        },
        ropsten: {
            provider: function () {
                return new HDWalletProvider(PRIVATEKEY, APIKEY);
            },
            network_id: 3,
            gas: 4000000, //make sure this gas allocation isn't over 4M, which is the max
        },
    },
    compilers: {
        solc: {
            version: "0.8.11",
        },
    },
};
