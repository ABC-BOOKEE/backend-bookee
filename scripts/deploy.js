async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const marketPlace = await ethers.getContractFactory("bookNft");

    const starteMint = await ethers.getContractFactory("bookMint");
    const market = await marketPlace.deploy(30);
    const starter = await starteMint.deploy();
  
    console.log("market Place address:", market.address);
    console.log("starter Place address:", starter.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });