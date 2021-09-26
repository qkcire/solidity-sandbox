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
// Arrays
bytes32[5] nicknames; // static array
bytes32[] names; // dynamic array
uint newLength = names.push("John"); // adding
// returns new length of the array
// Length
names.length; // get length
names.length = 1; // lengths can be set (for
// dynamic arrays in storage only)

// multidimensional array
uint x[][5]; // arr with 5 dynamic array elements
// (opp order of most languages)

// Dictionaries (any type of any other type)
mapping (string => uint) public balances;
balances["charles"] = 1;
// balances["ada"] result is 0, all non-set key
// values return zeroes
// 'public' allows following from another contract
contractName.balances("charles"); // returns 1
// 'public' created a getter (but not setter)
// like the following:
function balances(string _account) returns (uint balance) {
    return balances[_account];
}

// Nested mappings
mapping (address => mapping (address => uint)) public custodians;

// To delete
delete balances["John"];
delete balances; // sets all elements to 0

// Unlike other languages, CANNOT iterate through
// all alements in mapping, without knowing source
// keys - can build data structure on top to do this.

// Structs
struct Bank {
    address owner;
    uint balance;
}
Bank b = Bank({
    owner: msg.sender,
    balance: 5
});
// or
Bank c = Bank(msg.sender, 5);
c. balance = 5; // set to new value
delete b;
// Sets to initial value, set all variables in
// struct to 0, except mappings

// Enums
enum State { Created, Locked, Inactive }; // often
// used for state machine
State public state; // Declare variable from enum
state = State.created;
// enums can be explicitly converted to ints
uint createdState = uint(State.Created); // 0

// Data locations: Memory vs. storage vs. calldata
// - all complex types (arrays, structs) have a
// data location 'memory' does not persist, 
// 'storage' does default is 'storage' for local
// and state variables; 'memory' for func params
// stack holds small local variables

// for most types, can explicitly set which data
// location to use

// 3. Simple operators
// Comparisons, bit operators and arithmetic
// operators are provided
// exponentiation: **
// exclusive or: ^
// bitwise negation: ~

// 4. Global Variables of note
// ** this **
this; // address of contract life to transfer
// remaining balance to party
this.balance;
this.someFunction(); // Calls func externally
// via call, not via internal jump

// ** msg - Current message received by the
// contract ** **
msg.sender; // address of sender
msg.value; // amount of ether provided to this
// contract in wei, the function should be
// marked "payable"
msg.data; // bytes, complete call data
msg.gas; // remaining gas

// ** tx = This transaction **
tx.origin; // address of sender of the transaction
tx.gasprice; // gas price of the transaction

// ** block - information about current block **
now; // current time (approximately), alias for
// block.timestamp (uses Unix time) NOTE that
// this can be manipulated by miners, so use carefully

block.number; // current block number
block.difficulty; // current block difficulty
block.blockhash(1); // retursn bytes32, only works
// for most recent 256 blocks
block.gasLimit();

// ** storage - persistent storage hash **
storage['abc'] = 'def'; // maps 256 bits words

// 5. FUNCTIONS AND MORE
// A. Functions
// Simple function
function increment(uint x) return (uint) {
    x += 1;
    return x;
}

// Functions can return many arguments, and by
// specifying returned arguments name don't
// need to explicitly return
function increment(uint x, uint y) returns (uint x, uint y) {
    x += 1;
    y += 1;
}

// Call previous function
uint (a, b) = increment(1,1);

// 'view' (alias for 'constant')
// indicates that function does not/cannot change
// persistent vars
// View function execute locally, not on blockchain
// NOTE: constant keyworld will soon be deprecated
uint y = 1;

function increment(uint x) view returns (uint x) {
    x += 1;
    y += 1; // this line would fail since y is a
    // state variable and can't be changed in a
    // view function
}

// 'pure' is more strict than 'view' or 
// 'constant', and does not even allow reading
// of state vars
// The exact rules are more complicated, so
// see more about view/pur:
// http://solidity.readthedocs.io/en/develop/contracts.html#view-functions

// 'Function Visibility specifiers'
// These can be placed where 'view' is, including:
// public - visible externally and internally (
// default for function
// external - only visible externally (including
// a call made with this.)
// private - only visible in the current contract
// internal - only visible in current contract,
// and those deriving from it.

// Generally, a good idea to mark each function
// explicitly

// Functions hoisted - and can assign a function
// to a variable.
funciton a() {
    var z = b;
    b();
}

function b() {

}

// All functions that receive ether must be
// marked 'payable'
function depositEther() public payable {
    balances[msg.sender] += msg.value;
}

// Prefer loops to recursion (max call stack
// depth is 1024)
// Also, don't set up loops that you haven't
// bounded, as this can hit the gas limit

// B. Events
// Events are notify external parties; easy to
// search and access events from outside blockchain
// (with lightweight clients)
// typically declare after contract parameters

// Typically, capitalized - and add Log in front
// to be explicit and prevent confusion with a
// function call


// Declare
event LogSent(address indexed from, address indexed to, uint amount);
// note capital first letter

// Call
LogSent(from, to, amount);

/**
For an external party (a contract or external
entity), to watch using the Web3 Javascript 
library:

The following is Javascript code, not Solidity
code
Coin.LogSent().watch({}, '', function(error, result) {
    if (!error) {
        console.log("Coin transfer: " + 
        result.args.amount +
                " coins were sent from " +
        result.args.from +
                " to " + result.args.to + ".");
            console.log("Balances now:\n" + 
                "Sender: " +
        Coin.balances.call(result.args.from) + 
                "Receiver: " +
        Coin.balances.call(result.args.to));
    }
})
**/

// Common paradigm for one contract to depend on
// another (e.g., a contract that depends on
// current exchange rate provided by another)

// C. Modifiers
// Modifiers validate inputs to functions such as
// minimal balance or use auth;
// Similar to guard clause in other languages

// '_' (underscore) often included as last line
// in body, and indicates function being called
// should be placed there.
modifier onlyAfter(uint _time) { require (now >= _time); _; }
modifier onlyOwner { require(msg.sender == owner) _; }
// commonly used with state machines
modifier onlyIfStateA (State currState) {
    require(currState == State.A) _; }
}

// Append right after function declaration
function changeOWner(newOwner) {
    onlyAfter(someTime)
    onlyOwner()
    onlyIfState(State.A) {
        owner = newOwner;
    }
}

// Underscore can be included before end of body,
// but explicitly returning will skip, so use
// carefully.
modifier checkValue(uint amount) {
    _;
    if (msg.value > amount) {
        uint amountToRefund = amount - msg.value;
        msg.sender.transfer(amountToRefund);
    }
}

// 6. BRANCHING AND LOOPS

// All basic logic blocks work - including
// if/else, for, while, break, continue
// return - but no switch

// Syntax same as javascript, but no type 
// conversion from non-boolean to boolean
// (comparison operators must be used to get
// the boolean val)

// For loops that are determined by user behavior,
// be careful - as contracts have a maximal amount
// of gas for a block of code - and will fail
// if that is exceeded.

// For example:
for(uint x = 0; x < refundAddressList.length; x++) {
    refundAddressList[x].transfer(SOME_AMOUNT);
}

// Two errors above:
// 1. A failure on transfer stops the loop from
// completing, tying up money.
// 2. This loop could be arbitrarily long
// (based on the amount of users who need refunds),
// and therefore may always fail as it exceeds the
// max gas for a block.
// Instead, you should let people withdraw 
// individually from their subaccount, and mark
// withdrawn e.g., favor pull payments over
// push payments.

// 7. OBJECTS/CONTRACTS
// A. Calling external contract
contract InfoFeed {
    function info() payable returns (uint ret) {
        return 42;
    }
}

contract Consumer {
    InfoFeed feed; // points to contract on blockchain

    // Set feed to existing contract instance
    function setFeed(address addr) {
        // automatically cast, be careful;
        // constructor is not called
        feed = InfoFeed(addr);
    }

    // Set feed to new instance of contract
    function createNewFeed() {
        feed = new InfoFeed(); // new instance
        // created; constructor called
    }

    function callFeed() {
        // final parentheses call contract, can
        // optionally add custom ether value
        // or gas
        feed.info.value(10).gas(800)();
    }
}

// B. Inheritance
// Order matters, last inherited contract (i.e.,
// 'def') can override parts of previously 
// inherited contracts
contract MyContract is abc, def("a custom argument to def") {

    // Override function
    function z() {
        if (msg.sender == owner) {
            def.z(); // call overridden function
            // from def
            super.z(); // call immediate parent
            // overridden function
        }
    }
}

// abstract function
function someAbstractFunction(uint x);
// cannot compiled, so used in base/abstract
// contracts that are then implemented.

// C. Import

import "filename";
import "github.com/ethereum/dapp-bin/library/iterable_mapping.sol";

// 8. OTHER KEYWORDS

// A. Selfdestruct
// selfdestruct current contract, sending funds
// to address (often creator)
selfdestruct(SOME_ADDRESS);

// removes storage/code from current/future blocks
// helps thin clients, but previous data persists
// in blockchain.

// Common pattern, lets owner end the contract and
// received remaining funds
function remove() {
    if(mssg.sender == creator) { // Only let
        // the contract creator do this
        selfdestruct(creator);
    }
}

// May want to deactivate contract manually, rather
// than selfdestruct (ehter sent to selfdestructed
// contract is lost)

// 9. CONTRACT DESIGN NOTES

// A. Obfuscation
// All variables are publicly viewable on
// blockchain, so anything that is private needs
// to be obfuscated (e.g., hashed w/ secret)

// Steps: 1. Commit to something, 2. Reveal commitment
keccack256("some_bid_amount", "some secret");
// commit

// call contract's reveal function in the future
// showing bid plus secret that hashes to SHA3
reveal(100, "mySecret");

// B. Storage Optimization
// Writing to blockchain can be expensive, as data
// is stored forever; encourages smart ways to use
// memory (eventually, compilation will be better,
// but for now benefits to planning data structures -
// and storing min amount in blockchain)

// Cost can often be high for items like multi-
// dimensional arrays cost is for storing data -
// not declaring unfilled variables)

// C. Data access in blockchain
// Cannot restrict human or computer from reading
// contents of transaction or transaction's state

// While 'private' prevents other *contracts* from
// reading data directly - any other party can still
// read data in blockchain

// All data to start of time is stored in blockchain,
// so anyone can observe all previous data and changes.

// E. Oracles and External Data
// Oracles are ways to interact with your smart
// contracts outside the blockchain.
// They are used to get data from the real world,
// send post requests, to the real world or vice-versa.

// Time-based implementations of contracts are also
// done through oracles, as contracts need to be
// directly called and can not "subscribe" to a time.
// Due to smart contracts being decentralized, you
// also want to get your data in a decentralized manner,
// other your run into the centralized risk that smart
// contract design matter prevents.

// The easiest way to get and use pre-boxed decentralized
// data is with Chainlink Data Feeds
// https://docs.chain.link/docs/get-the-latest-price
// We can reference on-chain reference points that 
// have already been aggregated by multiple sources
// and delivered on-chain, and we can use it as a 
// "data bank" of sources.

// You can see other examples making API calls here:
// https://docs.chain.link/docs/make-a-http-get-request

// And you can of course build your own oracle
// network, just be sure to know how centralized vs.
// decentralized your application is.

// Setting up oracle networks yourself

// D. Cron Job
// Contracts must be manually called to handle time-
// based scheduling; can create external code to regularly
// ping, or provide incentives (ether) for others.

// E. Observer Pattern
// An Observer Pattern lets you register as a
// subscriber and register a function which is
// called by the oracle (note, the oracle pays
// for this action to be run).
// Some similarities to subscription in Pub/sub.

// This is an abstract contract, both client and
// server classes import the client should implement
contract SomeOracleCallback {
    function oracleCallback(int _value, uint _time, bytes32 info) external;
}

contract SomeOracle {
    SomeOracleCallback[] callbacks; // array of
    // all subscribers
    // Register subscriber
    function addSubscriber(SomeOracleCallback a) {
        callbacks.push(a);
    }

    function notify(value, time, info) private {
        for (uint i = 0; i < callbacks.length; i += 1) {
            // all called subscribers must implement
            // the oracleCallback
            callbacks[i].oracleCallback(value, time, info);
        }
    }

    function doSomething() public {
        // Code to do something
        // Notify all subscribers
        notify(_value, _time, _info);
    }
}

// Now, your client contract can addSubscriber
// by importing SomeOracleCallback and registering
// with some Oracle

// F. State Machines
// see example below for State enum and inState modifier

// 10. OTHER NATIVE FUNCTIONS

// Currency units
// Currency is defined using wei, smallest unit
// of Ether
uint minAmount = 1 wei;
uint a = 1 finney; // 1 either = 1000 finney
// Other units, see: http://ether.fund/tool/converter

// Time units
1 == 1 second
1 minutes == 60 seconds

// Can multiply a variable times unit, as units
// are not stored in a variable
uint x = 5;
(x * 1 days); // 5 days

// Careful about leap seconds/years with equality
// statements for time
// (instead, prefer greater than/less than)

// Cryptography
// All strings passed are concatenated before
// hash action
sha3("ab", "cd");
ripemd160("abc");
sha256("def");