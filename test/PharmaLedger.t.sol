// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/PharmaLedger.sol";

contract PharmaLedgerTest is Test {
    PharmaLedger public ledger;
    
    // Setting up 3 fake wallets for testing
    address public admin = address(1);
    address public researcher = address(2);
    address public unauthorizedUser = address(3);

    function setUp() public {
        vm.prank(admin);
        ledger = new PharmaLedger();
    }

    // TEST 1: Can the admin authorize a researcher?
    function test_AuthorizeResearcher() public {
        vm.prank(admin);
        ledger.authorizeResearcher(researcher);
        assertTrue(ledger.authorizedResearchers(researcher));
    }

    // TEST 2: Can an authorized researcher upload data?
    function test_UploadTrialData() public {
        vm.prank(admin);
        ledger.authorizeResearcher(researcher);

        vm.prank(researcher);
        ledger.uploadTrialData("Phase 1 Trial", "QmHash123");

        (uint256 id, address res, string memory title, string memory hash, ) = ledger.getTrialData(1);
        
        assertEq(id, 1);
        assertEq(res, researcher);
        assertEq(title, "Phase 1 Trial");
        assertEq(hash, "QmHash123");
    }

    // TEST 3: Does the contract block unauthorized users? (UPDATED!)
    function test_RevertWhen_UnauthorizedUpload() public {
        vm.prank(unauthorizedUser); 
        
        // We explicitly tell Foundry: "Hey, the VERY NEXT line should crash/revert!"
        vm.expectRevert("Not an authorized researcher"); 
        
        // This will fail, which means our security works and we pass the test!
        ledger.uploadTrialData("Fake Trial", "QmFakeHash"); 
    }
}