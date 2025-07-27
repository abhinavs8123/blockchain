// SPDX-License-Identifier: MIT
//it tells it islicensed or not
pragma solidity ^0.8.0;

contract Voting {
    address public owner;

    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    constructor(string[] memory _candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < _candidateNames.length; i++) {
            candidates.push(Candidate({
                name: _candidateNames[i],
                voteCount: 0
            }));
        }
    }

    modifier onlyOnce() {
        require(!hasVoted[msg.sender], "You have already voted.");
        _;
    }

    function vote(uint _candidateIndex) public onlyOnce {
        require(_candidateIndex < candidates.length, "Invalid candidate.");
        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = candidates[winnerIndex].name;
        winnerVotes = maxVotes;
    }
}