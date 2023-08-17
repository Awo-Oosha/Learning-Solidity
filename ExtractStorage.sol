// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Inheritances and Overrides

import "./SimpleStorage.sol";

// "is" Keyword means ExtraStorage is a child of SimpleStore
// it will inherit all the functions of simpleStorage

contract ExtraStorage is SimpleStorage {
    // override 
    function store(uint _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 10;
    }
}