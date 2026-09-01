// Import the Pinata SDK and our hidden environment variables
const { PinataSDK } = require("pinata");
const { File } = require("buffer");
require("dotenv").config();

// Initialize Pinata with our secure keys
const pinata = new PinataSDK({
    pinataJwt: process.env.PINATA_JWT,
    pinataGateway: process.env.GATEWAY_URL
});

async function uploadClinicalTrial() {
    try {
        console.log("Preparing clinical trial data...");

        // 1. We create a dummy JSON object representing the heavy clinical trial data
        const trialData = JSON.stringify({
            patientCount: 150,
            drugTested: "Experimental_Neuro_V1",
            successRate: "87.5%",
            notes: "No severe adverse reactions observed during Phase 1."
        });

        // 2. Convert it into a file format Pinata can read
        const file = new File([trialData], "Phase1_Trial_Results.json", { type: "application/json" });

        console.log("Uploading to IPFS via Pinata...");

        // 3. Upload the file to the decentralized web
        const upload = await pinata.upload.public.file(file);
        
        console.log("✅ Upload Successful!");
        console.log("This is the IPFS Hash to send to the Smart Contract:", upload.cid);

    } catch (error) {
        console.error("Error uploading to IPFS:", error);
    }
}

uploadClinicalTrial();