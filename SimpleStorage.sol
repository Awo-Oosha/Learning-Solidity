// SPDX-License-Identifier: MIT

// Start with the solidity Version. 
// Use ^ to specify a version upward
// To specify between a specify range of version >=0.8.7 <0.9.0
pragma solidity ^0.8.18;

// Create a Contract 
contract SimpleStorage {
    // boolean => bool hasFavoriteNumber = false;
    // uint => uint256 hasFavoriteNumber = 123;
    // int => int256 hasFavoriteNumber = -123;
    // string => string favoriteNumber = "Five";
    // address => address myaddr = 0x2d1bC737176d108876F6E67f08B94539F2C0BDa6;
    // bytes32 => bytes favoritebyte = "six";

    uint256 favoriteNumber; // The default is 0 => uint256 favoriteNumber = 0;
    People public  person = People({favoriteNumber: 2, name: "Patrick"});

    // Structs.
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    //Array 
    People[] public people;

    //there are 6 places you can store data in solidity => Stack, Memory, Storage, Calldata, Code, Logs
    // calldata  & memory => means the variable is only going to exists temporarily
    // storage variables exists even outside of just the function execution

    function addPerson(string memory _name, uint256 _favoriteNumber) public {

        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    } 

    // Mapping => Looks like a dictionary
    mapping (string => uint256) public  nameToFavoriteNumber;

    // Function
    // Lets change the value of the favorite to some new number;
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber + 1;
        
    }
    // Functions or Variables can have one or up to four visibilty specifiers
    // public => visible externally and internally(creates a getter function for storage/state variable)
    //private => only visible in the current contract
    //external => only visible externally (only for functions) can only be message-called via (this.func)
    //internal => only visible internally

    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }
    // view and pure function when called alone don't spend gas.
    // if a gas calling function calls a view or pure function only then will it cost gas.
    // view means we are just going to read state and not modifying it.
    // pure also disallow any modification and reading from the blockchain state


   

}
// 0xd9145CCE52D386f254917e481eB44e9943F39138