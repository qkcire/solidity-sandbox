// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/// @title Voting with delegation.
contract Ballot {
  // This declares a new complext type which will
  // be used for variables later.
  // It will represent a singler voter.
  struct Voter {
    uint weight; // weight is accumulated by delegation
    bool voted; // if true, that person already voted
    address delegate; // person delegated to
    uint vote; // index of the voted proposal
  }

  // This is a type for a single proposal.
  struct Proposal {
    bytes32 name; // short name (up to 32 bytes)
    uint voteCount; // number of accumulated votes
  }

  address public chairperson;

  // This declares a state variable that
  // stores a 'Voter' struct for each possible address.
  mapping (addres => Voter) public voters;

  // A dynamically-sized array of 'Proposal' structs.
  Proposal[] public proposals;

  /// Create a new ballot to choose one of 'proposalNames'.
  constructor(bytes32[] memory proposalNames) {
    chairperson = msg.sender;
    votes[chairperson].weight = 1;

    // For each of the provided proposal names,
    // create a new proposal object and add it
    // to the end of the array.
    for (uint i = 0; i < proposalNames.length; i += 1) {
      // `Proposal({...})` creates a temporary
      // Proposal object and `proposal.push(...)`
      // appends it to the end of `proposals`.
      proposals.push(Proposal({
        name: proposalNames[i],
        votCount: 0
      }));
    }
  }

}