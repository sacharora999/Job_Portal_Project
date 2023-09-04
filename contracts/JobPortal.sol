// SPDX-License-Identifier: AFL-3.0
pragma solidity ^0.8.0;

contract JobPortal {

	struct user {
	    uint256 id;
        string fname;
        string lname;
        uint256 number;
        string uaddress;
        uint256 anumber;
        string pass;
        string usertype;
    }

    struct jobpool {
	    uint256 jobid;
        string jobname; 
        string jobloc; 
        uint256 jobduration;
        uint256 jobwage;
        string jobcontactpersion;
        uint256 jobcontact;        
    }

    struct userjob_rating {
        uint256 prkey;
        uint256 jobid;
        uint256 userid;
        string jname;
        uint256 cuserid;
        uint rateing;
        string comment;
    }

    struct applied {
        uint256 pkey;
        uint256 jobid;
        uint256 userid;
        string jname;
    }

    
    uint256 applied_count = 0;
    mapping(uint256 => applied) m_applied;

    mapping(uint256 => user) m_user;
    user[] public um;

    uint128 jobpool_count = 0;
    mapping(uint256 => jobpool) m_jobpool;

    uint256 userjob_rating_count;
    mapping(uint256 => userjob_rating) m_userjob_rating;

    function newUser (uint256 _id, string memory _pass,string memory _fname,string memory _lname,string  memory _uaddress,uint256 _number,uint256 _anumber,string memory _usertype) public {
        JobPortal.user memory usernew = user(_id,_fname,_lname,_number,_uaddress,_anumber,_pass,_usertype);
        m_user[_id] = usernew;
        um.push(usernew);
    }

    function jobApplied (uint256 _jobid,uint256 _userid,string memory _jname) public {
        applied_count++;
        m_applied[applied_count] = applied(applied_count,_jobid,_userid,_jname);
    }

    function newJobpool (string memory _jobname,string memory _jobloc,uint256 _jobduration,uint256 _jobwage,string memory _jobcontactpersion,uint256 _jobcontact) public {
        jobpool_count++;
        m_jobpool[jobpool_count] = jobpool(jobpool_count,_jobname,_jobloc,_jobduration, _jobwage,_jobcontactpersion,_jobcontact);
    }

    function newWorkmenRating (uint256 _jobid,uint256 _userid,string memory _jname,uint256 _cuserid,uint _rateing,string memory _comment) public {
        userjob_rating_count++;
        m_userjob_rating[userjob_rating_count] = userjob_rating(userjob_rating_count,_jobid,_userid,_jname,_cuserid,_rateing,_comment);
    }

      function jobPoolCount () view public returns (uint256) {
        return jobpool_count;
    }
      function workmenRatingCount () view public returns (uint256) {
        return userjob_rating_count;
    } 

    function getRating(uint256 id) view public returns(uint256,uint256,string memory,uint256,uint,string memory) {
         return(m_userjob_rating[id].jobid,m_userjob_rating[id].userid,m_userjob_rating[id].jname,m_userjob_rating[id].cuserid,m_userjob_rating[id].rateing,m_userjob_rating[id].comment);
    }   
    
    function getJobs(uint256 id) view public returns(uint256,string memory,string memory,uint256,uint256,string memory,uint256) {
        return (m_jobpool[id].jobid, m_jobpool[id].jobname, m_jobpool[id].jobloc, m_jobpool[id].jobduration, m_jobpool[id].jobwage, m_jobpool[id].jobcontactpersion, m_jobpool[id].jobcontact);
    }
    
    function getUser(uint256 id) view public returns(string memory,string memory,uint256,string memory,uint256,string memory) {
        return (m_user[id].fname,m_user[id].lname,m_user[id].number,m_user[id].uaddress,m_user[id].anumber,m_user[id].usertype);
    }

    function getusertype(uint256 id) view public returns(string memory,string memory) {
     return(m_user[id].pass,m_user[id].usertype);     
    }

     function getapplied(uint256 pkey) view public returns(uint256,uint256,string memory) {
     return(m_applied[pkey].jobid,m_applied[pkey].userid,m_applied[pkey].jname);     
     }

    function getRatings(uint256 _id) view public returns (uint256) {
        uint256 workerrating;
        uint256 dcount;
        for(uint i = 0 ; i < userjob_rating_count; i++) {
            if(m_userjob_rating[_id].jobid == _id) {
                workerrating = workerrating + m_userjob_rating[_id].rateing;
                dcount++;
            }
        }
        uint rating = workerrating / dcount;
        return rating;
    }
}
