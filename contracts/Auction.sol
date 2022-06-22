pragma solidity >=0.4.16 <0.9.0;

contract AuctionHouse{

    address public BUYER = msg.sender;
    address NFT_ADDRESS = address(0x0); //temporarily just a jpeg
    address OWNER_ADDRESS = address(0x0); //temporarily no owner

    uint numberOfBids = 0;

    uint startTime;

    struct AuctionItem{
        address owner;
        address NFT;
        uint price; //Will be calculated into wei
        uint timeRemaining;
    }

    AuctionItem public newItem;
    constructor(){
        newItem.owner = OWNER_ADDRESS;
        newItem.NFT = NFT_ADDRESS;
        newItem.price = 1 ether; //need to change this dynamically
        newItem.timeRemaining = 60 minutes;
        }


    /**
    Associate highest bid with highest bidder in order to track who will win
     */
    mapping(uint => address) public highestBidder;
    
    /**
    Event that will trigger the current bid price to update on front end
     */
    event newHighestBidder(uint newBid);

    /**
    Function to place bid
     */
    function _placeBid(uint bidPrice) external payable{
        require(!auctionComplete());
        require(newItem.price < bidPrice);
        require(msg.value >= bidPrice);
        highestBidder[bidPrice] = BUYER;
        newItem.price = bidPrice;
        numberOfBids++;
        emit newHighestBidder(bidPrice);
    }

    /**
    Keep record of starting time    
     */
    function auctionStart() public{
        startTime = block.timestamp;
    }

    /**
    Check if the Auction time has been exceeded
     */
    function auctionComplete() public view returns(bool){
        return (block.timestamp >= (startTime + newItem.timeRemaining));
    }

    /*  ::: Will eventually need to transfer ownership with something like:

    function transferOwner() smt smt (){
        newItem.owner = BUYER
        (does one have to relinquish ownership?)
        :: I may have to import the ERC721 contract from OpenZepplin,
        :: Perhaps there is also an API of sorts on OpenSeas that will allow for uploading NFT images to other sites then
        complete the transfers off of OpenSea.
        }

        ::: Will also need some function to trigger the end of the auction when the clock runs out.
    fuction goingGoingGone() {
        if (auctionComplete){
            initiate transfer of the NFT;
            load next NFT;
            initialize new instance of the auction;
        }
    }
     */

}

// SideNote on calling 'truffle migrate': https://ethereum.stackexchange.com/questions/42711/the-reason-for-could-not-find-artifacts-for-in-truffle