// 1. DATA TYPES AND ASSOCIATED METHODS
// uint used for currency amount (there are
// no doubles or floats) and for dates (in 
// unix time).
uint x;

// int of 256 bits, cannot be changed after
// instantiation
int constant a = 8;
int256 constant a = 8; // same effect as line 
// above, here the 256 is explicit.
uint constant VERSION_ID = 0x123A1; // A hex
// constant with 'constant', compiler replaces
// each occurrence with actual value.

// All state variables (those outside a function)
// are by default 'internal' and accessible
// inside contract and in all contracts that
// inherit ONLY need to explicitly set to 'public'
// to allow external contracts to access
int 256 public a = 8;

// For int and uint, can explicitly set space in
// steps of 8 up to 256 e.g.m int8, int16, int24
uint8 b;
int64 c;
uint248 e;

// Be careful that you dont' overflow and protect
// against attacks that do. For example, for an
// addition, you'd do:
uint256 c = a + b;
assert(c >= a); // assert tests for internal
// invariants; require is used for user inputs.
// For more examples of common arithmetic issues,
// see Zeppelin's SafeMath library
// https://github.com/OpenZeppelin/zeppelin-solidity/
// blob/master/contracts/math/SafeMath.sol

// No random function built in, you can get a 
// pseudo-random number by hashing the current
// blockhas, or get a truely random number using
// something liek Chainlinke VRF.

// Type casting
int x = int(b);

bool b = true; // or do 'var b = true;' for
// inferred typing

// Addresses - holds 20 byte/160 bit Ethereum
// addresses. No arithmetic allowed
address public owner;

// Types of accounts:
// Contract account: address set on create (func
// of creator address, num transactions sent)
// External Account: (person/external entity):
// address created from public key.

// Add 'public' field to indicate publicly/
// externally accessible.
// a getter is automically created, but NOT a
// setter

// All addresses can be sent ether
owner.transfer(SOME_BALANCE); // fails and
// reverts on failure.

// Can also do a lower level .send call,
// which returns a false if it failed
if (owner.send) {} // REMEMBER: wrap send in
// 'if', as contract addresses have functions
// executed on send and these can fail.
// Also, make sure to deduct balances BEFORE
// attempting a send, as there is a rish of a
// recursive call that can drain the contract.

// Can check balance
owner.balance; // the balance of the owner
// (use or contract)

// Bytes available from 1 to 32
byte a;
bytes2 b;
bytes32 c;

// Dynamically sized bytes
bytes m; // A special array, same as byte[] 
// array (but packed tightly)
// More expensive than byte1-byte32. so use
// those when possible.

// Same as bytes, but does not allow length
// or index access (for now)
string n = "hello"; // Stored in UTF8, note
// double quotes, not single string utility
// functions to be added in future prefer
// bytes32/bytes, as UTF8 uses more storage.

// Type inference
// var does inferred typing based on first
// assignment, can't be used in function
// parameters.
var a = true;
// use carefully, inference may provide wrong
// type, e.g., an int8, when a counter need
// to be int16

// var can be used to assign function to
// variable
function a(uint x) returns (uint) {
    return x * 2;
}
var f = a;
f(22);

// by default, all vaules are set to 0 on
// instantiation.

// Delete can be called on most types
// (does not destroy value), but sets value
// to 0, the initial value)
uint x = 5;

// Destructuring/Tuples
(x, y) = (2, 7); // assign/swap multiple values

// 2. DATA STRUCTURES