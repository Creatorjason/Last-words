//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SelfDestruct{
    string public lastWord;

    constructor() payable{}
    function selfDestroy() external {
        selfdestruct(payable(msg.sender));
    }
    function isActivated() external pure returns(bool _confirm){
        _confirm = true;
    }
    function lastWords() external returns(string memory _word){
        lastWord = "What's up bro";
        _word = lastWord;
    }
   
}

contract TestSelfDestruct{

    string public lastWord;
    

    function callSelfDestroy(SelfDestruct _contract) external {
        _contract.selfDestroy();
    }
    function contractBal() external returns(uint){
        uint theBalance = address(this).balance;
        if (theBalance > 0){
            lastWord = "Bro, if this message gets to you, it's over man, farewell and take care!!";
        }
        return theBalance;
        
    }
    function getLastWords(address _contract) external {
        (bool confirm, bytes memory _theWord) = _contract.delegatecall(abi.encodeWithSignature("lastWords()"));
        require(confirm, "Failed");
        lastWord = string(_theWord);
        
        


    }
}
