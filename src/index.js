//Entry point to the application: this runs first
import MetaMaskOnboarding from '@metamask.onboarding';
import { Button } from 'bootstrap';
const onboarding = new MetaMaskOnboarding();
import Web3 from 'web3';
// import 'bootstrap/dist/css/bootstrap.css';


const isMetaMaskInstalled = () => {
    const {ethereum} = window;
    return Boolean(ethereum && ethereum.isMetaMask);
}
const onClickInstallMetaMask = () => {
    onboarding.startOnboarding();
    //loader.style.display = 'block';
}

async function connectWallet(){
    return await ethereum.request({method: 'eth_accounts'});
}


const MetaMaskClientCheck = () => {
    if(!isMetaMaskInstalled()){
        statusText.innerText = 'You need to Install a Wallet';

    }else{
        connectWallet().then((accounts) => {
            if(accounts && accounts[0]>0){
                connected(accounts)
            } else {
                statusText.innerHTML = 'Connect you Wallet'
            }
        })
    }
}
MetaMaskClientCheck();

Button.addEventListener('click', async () =>{
    Button.style.backgroundColor = '#cccccc';
    //loader.style.display = 'block';
    try{
        const accounts = await ethereum.request({method: 'eth_requestAccounts'})
        connected(accounts)
    } catch (error){
        console.error(error);
    }
})

function doColor1(){
  var cc1 = document.getElementById("div1");
  cc1.style.backgroundColor ="blue";
}

//This will get the MetaMask public key and give it to the smart contract
// function passMMAccount(myMM){
//     Contracts.Auction.getMM(myMM);
// }

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