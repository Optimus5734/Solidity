// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Calculator{
    uint256 result=0;

//function name(para) accessModifier return xyz{}
    function add(uint256 num) public {
        result += num;
    }
    function mul(uint256 num) public {
        result *= num;
    }
    function div(uint256 num) public {
        result /= num;
    }
    function sub(uint256 num) public {
        result -= num;
    }

    function get() public view returns(uint256){
        return result;
    }
}