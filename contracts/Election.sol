// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <=0.8.17;


contract Election {
     // Model a Candidate
     struct Candidate {
          uint id;
          string name;
          uint voteCount;
     }

     address private owner;

     mapping (address => bool) public voters;
     mapping(uint => Candidate) public candidates;
     uint public candidatesCount;



     event votedEvent (string mine, uint indexed _candidateId);


     constructor () {
          owner = msg.sender; 

          addCandidate("Shoaib husain");
          addCandidate("Arun");
     }


     modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
     }


     function addCandidate (string memory _name) public isOwner{
          candidatesCount+=1;
          candidates[candidatesCount] = Candidate(candidatesCount, _name,0);
          Candidate(candidatesCount, _name, 0);
     }


     function vote(uint _candidateId) public{

          // require that they haven't voted before
          require(!voters[msg.sender]);

          
         
          // require a valid candidate
          require(_candidateId > 0 && _candidateId <= candidatesCount);
          // record that voter has voted
          voters[msg.sender] = true;
          // update candidate vote Count
          candidates[_candidateId].voteCount ++;

          // trigger voted event
          emit votedEvent("voted right now", _candidateId);

     }


     function winner () public view returns(string memory winnerNameString) {
         uint maxVot = 0;
         uint secondMaxVot = 0;
         string memory winnerName = '';

          for(uint i =0; i <= candidatesCount; i++ ){
              if(candidates[i].voteCount >= maxVot){
                  secondMaxVot = maxVot;
                  maxVot = candidates[i].voteCount;
                  winnerName = candidates[i].name;
              }
            }

          if(maxVot >= 2 && maxVot != secondMaxVot ){
               return winnerName;
           }else{
                return "Winner is not select";
           }

     }


}