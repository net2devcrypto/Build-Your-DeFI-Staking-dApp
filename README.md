# Build-Your-DeFI-Staking-dApp
🤑Build Your Own Defi Staking dApp - The Official Github Repo with all the supporting code to follow the Youtube Tutorial so you can build your own DeFI Staking Rewards dApp.

<img src="https://raw.githubusercontent.com/net2devcrypto/misc/main/defi-vid-1.png" width="550" height="330">

** THE FILES ATTACHED TO THIS REPO ARE FOR EDUCATIONAL PURPOSES ONLY **

** NOT FINANCIAL ADVISE **

** USE IT AT YOUR OWN RISK** **I'M NOT RESPONSIBLE FOR ANY USE, ISSUES ETC.. **

ENTIRE PLAYLIST:
<a href="https://www.youtube.com/watch?v=ySBiVZaub1Q&list=PLLkrq2VBYc1Y4kL1lr-W_qwgI8De6M2BC" target="_blank"><img src="https://github.com/net2devcrypto/misc/blob/main/ytlogo2.png" width="90" height="20"></a>

<h3>Part 2 Repo</h3>

Click for video:

<a href="https://www.youtube.com/watch?v=d3K5cYSjUQ0&t=710s" target="_blank"><img src="https://github.com/net2devcrypto/misc/blob/main/ytlogo2.png" width="150" height="40"></a>

Part2 Folder Contents:

```shell
N2D-DeFI-MasterChef-SmartContract-Storage-Demo.sol
N2D-ERC20-N2DRewards-Token-SmartContract.sol
```

<h3>Part 3 Repo</h3>

Click for video:

<a href="https://youtu.be/JJFuuoR5h78" target="_blank"><img src="https://github.com/net2devcrypto/misc/blob/main/ytlogo2.png" width="150" height="40"></a>

Part3 Folder Contents:

```shell
N2D-DeFI-MasterChef-SmartContract-Add-Pools-Demo.sol
```

<h3>Part 4 Repo</h3>

Click for video:

<a href="https://www.youtube.com/watch?v=QnhCyZsUoNc" target="_blank"><img src="https://github.com/net2devcrypto/misc/blob/main/ytlogo2.png" width="150" height="40"></a>

Part4 Folder Contents:

```shell
N2D-DeFI-MasterChef-SmartContract-Update-Pools-Demo.sol
```

<h3>Part 5 Repo</h3>

Click for video:

<a href="https://youtu.be/EWh8Q3RU5JY" target="_blank"><img src="https://github.com/net2devcrypto/misc/blob/main/ytlogo2.png" width="150" height="40"></a>

Part5 Folder Contents:

```shell
N2D-DeFI-Staking-MasterChef-SmartContract-Final.sol
N2D-ERC20-N2DRewards-Token-Final.sol
```

<h3>Final Vid - Front-end Repo</h3>

Click for video:

<a href="https://youtu.be/-Cd1mV5HtjA" target="_blank"><img src="https://github.com/net2devcrypto/misc/blob/main/ytlogo2.png" width="150" height="40"></a>

Final Folder Contents:

<h4>contracts</h4>

```shell
N2D-DeFI-Staking-MasterChef-SmartContract-Final.sol
N2D-ERC20-N2DRewards-Token-Final.sol
N2D-DeFI-Staking-N2DRPay-SmartContract.sol
fakeusdt.sol
```
<h4>frontend</h4>

<h4>Steps to use practice tutorial files</h4>

DOWNLOAD "Final" Repo folder, then:

# 1- Deploy the contracts in the following order:

- N2D-ERC20-N2DRewards-Token-Final.sol

  * Copy the token smart contract address once deployed.

- N2D-DeFI-Staking-N2DRPay-SmartContract.sol

  * Provide the N2DR token smart contract address when deploying.
  * Copy the N2DRPay smart contract address once deployed.

- N2D-DeFI-Staking-MasterChef-SmartContract-Final.sol

  * Provide the N2DR token smart contract address when deploying.
  * Provide the N2DRPay smart contract address when deploying.
  * Provide all the additional values, refer to tutorial videos.

  * Copy the Masterchef smart contract address once deployed.

- fakeusdt.sol

  * Copy the fake USDT smart contract address once deployed.

# 2- Grant the MANAGER Role to the Masterchef smart contract address on both N2DR Token and N2DRPay smart contracts.

  * Refer to tutorial video for additional info.

# 3- Proceed to add the fake USDT Pool on the Masterchef Smart Contract.</h5>

  * Provide the fake USDT smart contract address recently deployed as lpToken address.
  * Add Allocation Point and _withUpdate to true
  * Refer to tutorial video for additional info.

# 4- Open your shell/terminal and navigate to the frontend folder then install dependencies.

```shell
cd final
cd frontend
npm i
```

# 5- Enter your Masterchef contract address to the config.js file.</h5>

```shell
const masterchefAddr = 'ENTER_MASTERCHEF_CONTRACT_ADDRESS';
```

CTRL + S to save !

# 6- Mint some test N2DR and USDT Tokens from your smart contracts and run your application!

```shell
cd final
cd frontend
npm run dev
```

Navigate to your web frontend and test!

Please watch full tutorial videos to understand the entire concept. It is important to learn how the DeFI Masterchef smart contract works!

Make your own mods and enjoy this tutorial, Knowledge is power!!
