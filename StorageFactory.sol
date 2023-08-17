// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// How to Use a Contract in Another Contract;
// import a contract;
import "./SimpleStorage.sol";

contract StorageFactory{
    // Create function that deploy the simple storage and save it to a local variable
    // How does storage factory know what simple storage lookslike?
    // It going to need to know the code of simple storage
    
    // create a global variable with type SimpleStorage Contract
    // Here Everytime we call the createSimpleStorageFunction It will Replace The Address of the simpleStorage
    // But we can keep a running list of all our deployed simpleStorage contracts
    // SimpleStorage public simpleStorage;

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        //create a new instance of SimpleStorage()
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // To interact with the SimpleStorage Contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // In order to interact with any Contract, You will need::
        // The Contract Address and The ABI ( ~Application Binary Interface )
        // To call the store function of our contract, Get the Contract Object

        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // call the store function on simpleStorage
        simpleStorage.store(_simpleStorageNumber);
    }

    // create a function to read from the contract

    function sfget(uint256 _simpleStorageIndex) public view returns(uint) {
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        return simpleStorage.retrieve();
    }
}