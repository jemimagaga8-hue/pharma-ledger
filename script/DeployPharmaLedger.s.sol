// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Script.sol";
import "../src/PharmaLedger.sol";

contract DeployPharmaLedger is Script {
    function run() external {
        // 1. Grab the private key from our computer's hidden environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // 2. Tell Foundry to start broadcasting our actions to the real blockchain
        vm.startBroadcast(deployerPrivateKey);

        // 3. Deploy the smart contract!
        PharmaLedger ledger = new PharmaLedger();

        // 4. Stop broadcasting
        vm.stopBroadcast();
        
        // (Optional) Log the address so we know where it deployed
        // console.log("PharmaLedger deployed to:", address(ledger));
    }
}