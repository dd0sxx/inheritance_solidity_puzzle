import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract } from "hardhat/internal/hardhat-network/stack-traces/model";
import { SimpleVoteNFT } from "../typechain-types/contracts/SimpleVoteNFT"
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("Simple Vote NFT", function () {

  let owner:SignerWithAddress, otherAccount:SignerWithAddress, contract:SimpleVoteNFT
 
   beforeEach (async function () {
    // Contracts are deployed using the first signer/account by default
    [owner, otherAccount] = await ethers.getSigners();

    const Contract = await ethers.getContractFactory("SimpleVoteNFT");
    contract = await Contract.deploy();
  })

  it("Should allow minting", async function () {
    await contract.connect(otherAccount).mint({value: ethers.utils.parseEther("0.01")})
    expect(await contract.balanceOf(otherAccount.address)).to.deep.equal(1);
    expect(await contract.getVotingPower(otherAccount.address)).to.deep.equal(1);
  }) 
  
  it("Should allow transferFrom", async function () {
    await contract.connect(otherAccount).mint({value: ethers.utils.parseEther("0.01")})
    await contract.connect(otherAccount).transferFrom(otherAccount.address, owner.address, 0);
    expect(await contract.balanceOf(otherAccount.address)).to.deep.equal(0);
    expect(await contract.balanceOf(owner.address)).to.deep.equal(1);
    expect(await contract.getVotingPower(owner.address)).to.deep.equal(1);
    expect(await contract.getVotingPower(otherAccount.address)).to.deep.equal(0);
  }) 
  
  it("Should allow safeTransferFrom", async function () {
    await contract.connect(otherAccount).mint({value: ethers.utils.parseEther("0.01")})
    await contract.connect(otherAccount)["safeTransferFrom(address,address,uint256)"](otherAccount.address, owner.address, 0);
    expect(await contract.balanceOf(otherAccount.address)).to.deep.equal(0);
    expect(await contract.balanceOf(owner.address)).to.deep.equal(1);
  }) 
});
