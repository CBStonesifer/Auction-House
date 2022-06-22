//Entry point to the application: this runs first

import Web3 from 'web3';
// import 'bootstrap/dist/css/bootstrap.css';

//import the json file created by the solidity file

/*configure contract address and ABI
Const contract = new web3.eth.Contract(
    CONTRACT_ABI
    CONTRACT_ADDRESS
)

*/

//setup Web3 local host provider and use to initialize the Contract 'Auction'
/*
Source: https://www.youtube.com/watch?v=FYhZPovlGZQ

let account;

const accountEl = document.getElementById('account);

const main = async () => {
    const accounts = await web3.eth.requestAccounts();
    account = accounts[0];
    accountEl.innerTest = account;
}

*/