import { network } from "hardhat";

const { ethers } = await network.connect({
  network: "zetaTestnet",
});

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  const WalletWhitelist = await ethers.getContractFactory(
    "WalletWhitelist",
    deployer
  );
  const initialAddresses = [
    "0x3d4a6c3a556BeAa19541686D5Abb2d8614eF24B1",
    "0x5aD32168e2E4eeD1ac4666a931da82ebd89d2177",
    "0x9D746EAC0c64d796d387aAa6F82ddadE0cf5E1AE",
    "0xB188a44D2b5353f7612a9Fe8b8Cd30e808cd203a",
    "0xf0a835C794Ee167C882aeafa584d22fa7375C27a",
  ] as [string, string, string, string, string];

  const contract = await WalletWhitelist.deploy(initialAddresses);

  await contract.waitForDeployment();

  const address = await contract.getAddress();
  console.log("Contract deployed at:", address);
}

main().catch(console.error);
