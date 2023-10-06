import { createWalletClient, custom } from "viem";
import { sepolia } from "viem/chains";
import masterChefAbi from "./masterchef.json";
import tokenAbi from "./erc20abi.json";
import { ethers } from "ethers";

const masterchefAddr = 'ENTER_MASTERCHEF_CONTRACT_ADDRESS';

const web3Provider = async () => {
  const [account] = await window.ethereum.request({
    method: "eth_requestAccounts",
  });

  const client = createWalletClient({
    account,
    chain: sepolia,
    transport: custom(window.ethereum),
  });
  return client;
};

const convertToEth = async (type, value) => {
    if (type == 'reward'){
        return Number(ethers.utils.formatEther(value)).toFixed('8');
    }
    else {
        return Number(ethers.utils.formatEther(value)).toFixed('2');
    }
}

const convertToWei = async (value) => {
  return ethers.utils.parseEther(value);
}

export async function connectWallet() {
  const connection = await web3Provider()
  const provider = new ethers.providers.Web3Provider(connection);
  const signer = provider.getSigner()
  const masterchef = new ethers.Contract(masterchefAddr, masterChefAbi, signer);
  return {connection, signer, masterchef, masterchefAddr};
}

export const fetchTokenBalance = async (tokenaddress, userwallet) => {
  const web3connection = await connectWallet();
  const tokencontract = new ethers.Contract(tokenaddress, tokenAbi, web3connection.signer);
  let poolBalance = await tokencontract.balanceOf(masterchefAddr);
  let pool = await convertToEth(null, poolBalance);
  let userBalance = await tokencontract.balanceOf(userwallet);
  let user = await convertToEth(null, userBalance);
  return {pool, user};
}

export const getPoolDetails = async () => {
    let web3connection = await connectWallet();
    let userwallet = web3connection.connection.account.address
    let masterchef = web3connection.masterchef;
    let poolLength = Number((await masterchef.poolLength()).toString());
    let poolArray = [];
    for (let i = 0; i < poolLength; i++){
        let poolInfo = await masterchef.poolInfo(i);
        let tokenAddress = poolInfo[0];
        let rewardPerTokenRaw = (poolInfo[3]).toString();
        let rewardPerToken = Number(await convertToEth('reward', rewardPerTokenRaw));
        let tokenbalances = await fetchTokenBalance(tokenAddress, userwallet);
        let userStakedArray = await masterchef.userInfo(i, userwallet);
        let userRewardRaw = (await masterchef.pendingReward(i, userwallet)).toString();
        let bonus = (await masterchef.BONUS_MULTIPLIER()).toString();
        let userReward = Number(await convertToEth('reward', userRewardRaw)).toFixed('2');
        let userStaked = Number(await convertToEth('reward', ((userStakedArray['amount']).toString()))).toFixed('2');
        let APR = ((1000 * rewardPerToken) * 100).toFixed('3');
        let poolstats = {
            "totalstaked": tokenbalances.pool,
            "apy": APR,
            'userstaked': userStaked,
            'reward': userReward,
            'multiplier': bonus,
            "userbalance": tokenbalances.user,
            "tokenaddr": tokenAddress
        }
        poolArray.push(poolstats);
    }
    return poolArray;
}

export const action = async (i, amount, tokenaddress, action) => {
  try{
    let amountToWei = (await convertToWei(amount)).toString();
    let web3connection = await connectWallet();
    let masterchef = web3connection.masterchef;
    let masterchefAddr = web3connection.masterchefAddr;
    if (action == "unstake") {
      let result = await masterchef.unstake(i, amountToWei).then(() => {
        return true;
      });
      return result;
    }
    else if (action == "stake") {
      const tokencontract = new ethers.Contract(tokenaddress, tokenAbi, web3connection.signer);
      let approveTransfer = await tokencontract.approve(masterchefAddr, amountToWei);
      let waitApproval = await approveTransfer.wait();
      if (waitApproval) {
        let result = await masterchef.stake(i, amountToWei).then(() => {
          return true;
        });
        return result;
      }
    }
  }
  catch {
    console.log('error')
  }
}

export const autoCompound = async () => {
  let web3connection = await connectWallet();
  let masterchef = web3connection.masterchef;
  let result = await masterchef.autoCompound().then(() => {
    return true;
  });
  return result;
}