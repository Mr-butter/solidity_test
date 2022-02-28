// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Election is ERC721, ERC721Enumerable {

    bool public ElectionResult = false;
uint public VotingCount = 0;
    // 후보 존재여부 매핑
    mapping(string => bool) _CandidateExists;

    constructor() ERC721("Election", "CCS"){
        
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        bool result;
    }

    Candidate[] public Candidates;

        mapping(address => bool) public voters;

    function mint(string memory name) public {
        // 후보가 없다면 
        require(!_CandidateExists[name]);
        require(Candidates.length < 5);
        // nft 권리와 함께 들어갈 이름
        Candidates.push(Candidate(Candidates.length,name,0,false));
        // 후보 어디에 있는지 찾기
        uint _id = Candidates.length - 1;
        _mint(msg.sender, _id);
        _CandidateExists[name] = true;
    }

        function vote(uint _Candidateid) public {
        // => 투표용 디앱(컨트랙트)를 구동한자가 투표자
        require(!voters[msg.sender]);
        require(_Candidateid >= 0);
        // 투표 진행 
        voters[msg.sender] = true;
        VotingCount++;
        // 투표수 증가
  Candidates[_Candidateid].voteCount++;
  if(Candidates[_Candidateid].voteCount == 3){
        ElectionResult = true;
        Candidates[_Candidateid].result = true;
  }

        // total 득표수 증가
        // numVote++;
        // emit sendMsg("투표 complete");
   
    }


    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}