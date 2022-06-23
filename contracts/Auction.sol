pragma solidity >=0.4.16 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

contract AuctionHouse is ERC721, Ownable{

    uint numberOfBids = 0;

    uint startTime;

    //Contract address => NFT_id => Auction Structure
    mapping(address => mapping(uint256 => AuctionItem)) public listings ; //listings[contract address][tokenId] => returns AuctionItem information

    struct AuctionItem{
        address owner;
        address NFT;
        uint price; //Will be calculated into wei
        uint timeRemaining;
    }

    // AuctionItem public newItem;
    // constructor(uint256 NFT_ADDRESS, address OWNER_ADDRESS, uint PRICE){
    //     newItem.owner = OWNER_ADDRESS;
    //     newItem.NFT = NFT_ADDRESS;
    //     newItem.price = PRICE;
    //     newItem.timeRemaining = 20 minutes;
    //     }


    /**
    Associate highest bid with highest bidder in order to track who will win
    Need to implement smt about keeping track of bids
     */
    mapping(uint => address) public highestBidder;
    
    /**
    Event that will trigger the current bid price to update on front end
     */
    event newHighestBidder(uint newBid);


    /** Add listing function that takes (price, contractAddress, tokenID)
            - erc721 NFT = erc721(contractAddress)
            - balance of (msg.sender, tokenId)  the person listing must own the nft
            - 
        We need: only the owner can list his NFT, so check if the proposed NFT is theirs
        We need: to intialize a listing of the NFT for auctioning
        We need: the owner to give approval of the transaction when the auction is over
     */
     function createListing(uint256 NFT_ADDRESS, address OWNER_ADDRESS, uint PRICE) public{
        ERC721 listedNFT = ERC721(contractAddress);
        require(ownerOf(listedNFT) == OWNER_ADDRESS);

     }
     
    /**
    Function to place bid
     */
    function _placeBid(uint bidPrice) external payable{
        require(!auctionComplete());
        require(newItem.price < bidPrice);
        require(msg.value >= bidPrice);
        highestBidder[bidPrice] = msg.sender; //consider what happens if funds are spent after placing the bid, before auction is over
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