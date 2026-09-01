// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title PharmaLedger
 * @dev A decentralized vault for anchoring clinical trial data hashes to the blockchain.
 */
contract PharmaLedger is Ownable {
    
    // ==========================================
    // DATA STRUCTURES
    // ==========================================
    struct ClinicalTrial {
        uint256 trialId;
        address researcher;
        string studyTitle;
        string ipfsHash;
        uint256 timestamp;
    }

    mapping(uint256 => ClinicalTrial) public trials;
    uint256 public trialCount;
    mapping(address => bool) public authorizedResearchers;

    // ==========================================
    // EVENTS
    // ==========================================
    event TrialUploaded(
        uint256 indexed trialId,
        address indexed researcher,
        string studyTitle,
        string ipfsHash,
        uint256 timestamp
    );

    event ResearcherAuthorized(address researcher);
    event ResearcherRevoked(address researcher);

    // ==========================================
    // CONSTRUCTOR
    // ==========================================
    constructor() Ownable(msg.sender) {}

    // ==========================================
    // ADMIN FUNCTIONS
    // ==========================================
    function authorizeResearcher(address _researcher) public onlyOwner {
        authorizedResearchers[_researcher] = true;
        emit ResearcherAuthorized(_researcher);
    }

    function revokeResearcher(address _researcher) public onlyOwner {
        authorizedResearchers[_researcher] = false;
        emit ResearcherRevoked(_researcher);
    }

    // ==========================================
    // CORE LOGIC
    // ==========================================
    function uploadTrialData(string memory _studyTitle, string memory _ipfsHash) public {
        require(authorizedResearchers[msg.sender], "Not an authorized researcher");
        require(bytes(_studyTitle).length > 0, "Study title cannot be empty");
        require(bytes(_ipfsHash).length > 0, "IPFS hash cannot be empty");

        trialCount++;

        trials[trialCount] = ClinicalTrial({
            trialId: trialCount,
            researcher: msg.sender,
            studyTitle: _studyTitle,
            ipfsHash: _ipfsHash,
            timestamp: block.timestamp
        });

        emit TrialUploaded(trialCount, msg.sender, _studyTitle, _ipfsHash, block.timestamp);
    }

    function getTrialData(uint256 _trialId) public view returns (
        uint256, address, string memory, string memory, uint256
    ) {
        require(_trialId > 0 && _trialId <= trialCount, "Trial does not exist");
        ClinicalTrial memory trial = trials[_trialId];
        return (trial.trialId, trial.researcher, trial.studyTitle, trial.ipfsHash, trial.timestamp);
    }
}