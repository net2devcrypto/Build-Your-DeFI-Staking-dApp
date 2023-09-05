// SPDX-License-Identifier: GPL-3.0

/*

Follow/Subscribe Youtube, Github, IM, Tiktok
for more amazing content!!
@Net2Dev
███╗░░██╗███████╗████████╗██████╗░██████╗░███████╗██╗░░░██╗
████╗░██║██╔════╝╚══██╔══╝╚════██╗██╔══██╗██╔════╝██║░░░██║
██╔██╗██║█████╗░░░░░██║░░░░░███╔═╝██║░░██║█████╗░░╚██╗░██╔╝
██║╚████║██╔══╝░░░░░██║░░░██╔══╝░░██║░░██║██╔══╝░░░╚████╔╝░
██║░╚███║███████╗░░░██║░░░███████╗██████╔╝███████╗░░╚██╔╝░░
╚═╝░░╚══╝╚══════╝░░░╚═╝░░░╚══════╝╚═════╝░╚══════╝░░░╚═╝░░░
THIS CONTRACT IS AVAILABLE FOR EDUCATIONAL 
PURPOSES ONLY. YOU ARE SOLELY REPONSIBLE 
FOR ITS USE. I AM NOT RESPONSIBLE FOR ANY
OTHER USE. THIS IS TRAINING/EDUCATIONAL
MATERIAL. ONLY USE IT IF YOU AGREE TO THE
TERMS SPECIFIED ABOVE.
*/

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./N2D-ERC20-N2DRewards-Token-SmartContract.sol";
 
contract N2DMasterChefV1 is Ownable, ReentrancyGuard {
        using SafeMath for uint256;
        using SafeERC20 for IERC20;

        struct UserInfo {
            uint256 amount;
            uint256 pendingReward;
        }

        struct PoolInfo {
            IERC20 lpToken;
            uint256 allocPoint;
            uint256 lastRewardBlock;
            uint256 rewardTokenPerShare;
        }

        N2DRewards public n2dr;
        address public dev;
        uint256 public n2drPerBlock;

        mapping(uint256 => mapping(address => UserInfo)) public userInfo;

        PoolInfo[] public poolInfo;
        uint256 public totalAllocation = 0;
        uint256 public startBlock;
        uint256 public BONUS_MULTIPLIER;

        constructor (
            N2DRewards _n2dr,
            address _dev,
            uint256 _n2drPerBlock,
            uint256 _startBlock,
            uint256 _multiplier
        ) public {
            n2dr = _n2dr;
            dev = _dev;
            n2drPerBlock = _n2drPerBlock;
            startBlock = _startBlock;
            BONUS_MULTIPLIER = _multiplier;

            poolInfo.push(PoolInfo({
                lpToken: _n2dr,
                allocPoint: 1000,
                lastRewardBlock: _startBlock,
                rewardTokenPerShare: 0
            }));
            totalAllocation = 1000;

        }

        function poolLength() external view returns (uint256) {
            return poolInfo.length;
        }

        function getPoolInfo(uint256 pid) public view returns (
            address lpToken,
            uint256 allocPoint,
            uint256 lastRewardBlock,
            uint256 rewardTokenPerShare
        ){
            return (
                (address(poolInfo[pid].lpToken)),
                poolInfo[pid].allocPoint,
                poolInfo[pid].lastRewardBlock,
                poolInfo[pid].rewardTokenPerShare
            );
        }
        
        function getMultiplier(uint256 _from, uint256 _to) public view returns (uint256){
            return _to.sub(_from).mul(BONUS_MULTIPLIER);
        }

        function updateMultiplier(uint256 multiplierNumber) public onlyOwner {
            BONUS_MULTIPLIER = multiplierNumber;
        }

        function checkPoolDuplicate(IERC20 token) public view {
            uint256 length = poolInfo.length;
            for (uint256 _pid = 0; _pid < length; _pid++){
                require(poolInfo[_pid].lpToken != token, "Pool Already Exists");
            }
        }

        function updateStakingPool() internal {
            uint256 length = poolInfo.length;
            uint256 points = 0;
            for (uint256 pid = 1; pid < length; pid++){
                points = points.add(poolInfo[pid].allocPoint);
            }
            if (points != 0){
                points = points.div(3);
                totalAllocation = totalAllocation.sub(poolInfo[0].allocPoint).add(points);
                poolInfo[0].allocPoint = points;
            }
        }

        function add(uint256 _allocPoint, IERC20 _lpToken) public onlyOwner {
            checkPoolDuplicate(_lpToken);
            uint256 lastRewardBlock = block.number > startBlock ? block.number : startBlock;
            totalAllocation = totalAllocation.add(_allocPoint);
            poolInfo.push(PoolInfo({
                lpToken: _lpToken,
                allocPoint: _allocPoint,
                lastRewardBlock: lastRewardBlock,
                rewardTokenPerShare: 0
            }));
            updateStakingPool();
        }

}