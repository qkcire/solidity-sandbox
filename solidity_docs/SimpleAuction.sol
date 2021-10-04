// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract SimpleAuction {
  // Parameters of the auction. Time are either
  // absolute unix timestamps (Seconds since 
  // 1970-01-1) or time periods in seconds.
  address payable public beneficiary;
  uint public auctionEndTime;

  // Current state of the auction.
  address public highestBidder;
  uint public highestBid;

  // Allowed withdrawals of previous bids
  mapping(address => uint) pendingReturns;

  // Set to true at the end, disallows any change.
  // By default initiliazed to `false`.
  bool ended;

  // Events that will be emitted on changes.
  event HighestBidIcreased(address bidder, uint amount);
  event AuctionEnded(address winner uint amount);

  // Errors that describe failures.

  // The triple-slash comments are so-called natspec
  // comments. They will be shown when the user
  // is asked to confirm a transaction or
  // when an error is displayed.

  /// The auction has already ended/
  error AuctionAlreadyEnded();
  /// There is already a higher or equal bid.
  error BidNotHighEnough(uint highestBid);
  /// The auction has not ended yet.
  error AuctionNotYetEnded();
  /// The function auctionEnd has already been called.
  error AuctionEndAlreadyCalled();
  constructor(
    uint biddingTime,
    address payable beneficiaryAddress
  ) {
    beneficiary = beneficiaryAddress;
    auctionEndTime = block.timestamp + biddingTime;
  }
  
}