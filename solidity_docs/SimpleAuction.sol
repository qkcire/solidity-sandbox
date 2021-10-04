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
  
  /// Bid on the auction with the value sent
  /// together with this transaction.
  /// The value will only be refunded if the
  // auction is not won.
  function bid() external payable {
    // No arguments are necessary, all
    // information is already part of
    // the transaction. The keyword payable
    // is required for the function to
    // be able to receive Ether.

    // Revert the call if the bidding
    // period is over.
    if (block.timestamp > auctionEndTime) {
      revert AuctionAlreadyEnded();
    }

    // If the bid if not higher, send the
    // money back (the revert statement
    // will revert all the changes in this
    // function execution including 
    // it having received the money).
    if (msg.value <= highestBid) {
      rever BidNotHighEnough(highestBid);
    }

    if (highestBid != 0) {
      // Sending back the money by simply using
      // highestBidder.send(highestBid) is a 
      // security risk because it could execute
      // an untrusted contract.
      // It is always safer to let the recipients
      // withdraw their money themselves.
      pendingReturns[highestBIdder] += highestBid;
    }
    highestBIdder = msg.sender;
    highestBid = msg.value;
    emit HighestBidIcreased(msg.sender, msg.value);
  }

  /// Withdraw a bid that was overbid.
  function withdraw() external returns (bool) {
    uint amount = pendingReturns[msg.sender];
    if (amount > 0) {
      // It is important to set this to zero because
      // the recipient can call this function again
      // as part of the receiving call before `send`
      // returns.
      pendingReturns[msg.sender] = 0;

      if (!payable(msg.sender).send(amount)) {
        // No need to call throw here, just reset the amount owing
        return false;
      }
    }
    return true;
  }

}