//Modified sample test configuration produced by Cody Seibert: https://github.com/codyseibert/web3-tickets/blob/master/contracts/Tickets.sol

const Auction = artifacts.require('Auction');
const assert = require('assert');
const { isTypedArray } = require('util/types');

contract('Auction', (accounts)=> {
    const BUYER = accounts[1];
    const NFT = 0;

    it('should allow a user to place a bid', async ()=> {
        const instance = await Auction.deployed();
        const auctionNFT = await instance.newItem();

        await instance.placeBid({from: BUYER, value: newItem.price + 1});
        const newHolder = await instance.newItem();

        assert.equal(newHolder.price, newItem.price + 1, 'The cost increased');

    });
});