// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.20;

contract Twitter{

uint16 public  limit=280;
    struct Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
//mapping user to it tweet this is how we declare map here tweet is the name of the map
    mapping(address=>Tweet[]) public tweets;
    address public owner;
    
    //Events
    event TweetCreated(uint256 id, address author,string content,uint256 timestamp);
    event TweetLike(uint256 id, address author,address liker,uint256 likeCount);
    event TweetUnlike(uint256 id, address author,address liker,uint256 likeCount);

constructor(){
    owner=msg.sender;
}

modifier mainOwner(){
    require(owner==msg.sender, "Hy you are not the owner!!!");
    _;
}



function changeTweetLimit(uint16 newTweetLimit) public mainOwner {
    limit=newTweetLimit; 
}


//When u specify that memory it actually allocate a temp memory to tweet to store the needed data 
//msg.sender(Ethereum address of the sender of a transaction) built-in global variable in Solidity used to identify who initiated a particular transaction.
function createTweet(string memory tweetString) public {
        bytes memory b=bytes(tweetString);
        require(b.length<=limit,"You have exceeded the word limit ");
        Tweet memory newTweet = Tweet({
            id:tweets[msg.sender].length,
            author:msg.sender,
            content:tweetString,
            timestamp:block.timestamp,
            likes:0
        });

        tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id,newTweet.author,newTweet.content,newTweet.timestamp);
    }
function likeTweets(uint256 id,address author) external{
    require(tweets[author][id].id==id, "Tweet do not exist");
    tweets[author][id].likes++;
    emit TweetLike(id,msg.sender,author,tweets[author][id].likes);
}
function unlikeTweets(uint256 id,address author) external{
    require(tweets[author][id].id==id, "Tweet do not exist");
    require(tweets[author][id].likes>0, "Likes cant go negative");
    tweets[author][id].likes--;
    emit TweetUnlike(id,msg.sender,author,tweets[author][id].likes);
}
function getTweets(uint i)public view returns (Tweet memory ){
        return tweets[msg.sender][i];
    }
function getAllTweets(address _owner)public view returns(Tweet[] memory){
        return tweets[_owner];
    }
function getTotalLikes(address _author) external view returns(uint){
    uint totalLikes=0;
    for(uint i=0 ;i<tweets[_author].length;i++){
        totalLikes=totalLikes+tweets[_author][i].likes;
    }
    return totalLikes;

    }
}