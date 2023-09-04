// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract JobPortal {

	struct user {
	    uint256 id;
        bytes32 fname;
        bytes32 lname;
        uint256 number;
        bytes32 uaddress;
        uint256 anumber;
        bytes32 pass;
        bytes32 usertype;
    }

    struct jobpool {
	    uint256 jobid;
        bytes32 jobname; 
        bytes32 jobloc; 
        uint256 jobduration;
        uint256 jobwage;
        bytes32 jobcontactpersion;
        uint256 jobcontact;        
    }

    struct userjob_rating {
        uint256 prkey;
        uint256 jobid;
        uint256 userid;
        bytes32 jname;
        uint256 cuserid;
        uint rateing;
        bytes32 comment;
    }

    struct applied {
        uint256 pkey;
        uint256 jobid;
        uint256 userid;
        bytes32 jname;
    }

    
    uint256 applied_count = 0;
    mapping(uint256 => applied) m_applied;

    mapping(uint256 => user) m_user;
    user[] public um;

    uint128 jobpool_count = 0;
    mapping(uint256 => jobpool) m_jobpool;

    uint256 userjob_rating_count;
    mapping(uint256 => userjob_rating) m_userjob_rating;

    //Add a new applicant
    function newUser (uint256 _id, bytes32 _pass,bytes32 _fname,bytes32 _lname,bytes32 _uaddress,uint256 _number,uint256 _anumber,bytes32 _usertype) public {
        JobPortal.user memory usernew = user(_id,_fname,_lname,_number,_uaddress,_anumber,_pass,_usertype);
        m_user[_id] = usernew;
        um.push(usernew);
    }


    //Applicants apply for a job 
    function jobApplied (uint256 _jobid,uint256 _userid,bytes32 _jname) public {
        applied_count++;
        m_applied[applied_count] = applied(applied_count,_jobid,_userid,_jname);
    }

    //Add a new Job to the portal
    function newJobpool (bytes32 _jobname,bytes32 _jobloc,uint256 _jobduration,uint256 _jobwage,bytes32 _jobcontactpersion,uint256 _jobcontact) public {
        jobpool_count++;
        m_jobpool[jobpool_count] = jobpool(jobpool_count,_jobname,_jobloc,_jobduration, _jobwage,_jobcontactpersion,_jobcontact);
    }

    //Provide a rating to an applicant 
    function newWorkmenRating (uint256 _jobid,uint256 _userid,bytes32 _jname,uint256 _cuserid,uint _rateing,bytes32 _comment) public {
        userjob_rating_count++;
        m_userjob_rating[userjob_rating_count] = userjob_rating(userjob_rating_count,_jobid,_userid,_jname,_cuserid,_rateing,_comment);
    }


    //Get Total Jobs Count
    function jobPoolCount () view public returns (uint256) {
        return jobpool_count;
    }


    //Get Total Rating Count
    function workmenRatingCount () view public returns (uint256) {
        return userjob_rating_count;
    } 


    
    function getRating(uint256 id) view public returns(uint256,uint256,bytes32,uint256,uint,bytes32) {
         return(m_userjob_rating[id].jobid,m_userjob_rating[id].userid,m_userjob_rating[id].jname,m_userjob_rating[id].cuserid,m_userjob_rating[id].rateing,m_userjob_rating[id].comment);
    }   
    
    //Get job details 
    function getJobs(uint256 id) view public returns(uint256,bytes32,bytes32,uint256,uint256,bytes32,uint256) {
        return (m_jobpool[id].jobid, m_jobpool[id].jobname, m_jobpool[id].jobloc, m_jobpool[id].jobduration, m_jobpool[id].jobwage, m_jobpool[id].jobcontactpersion, m_jobpool[id].jobcontact);
    }
    //Get applicant details 
    function getUser(uint256 id) view public returns(bytes32,bytes32,uint256,bytes32,uint256,bytes32) {
        return (m_user[id].fname,m_user[id].lname,m_user[id].number,m_user[id].uaddress,m_user[id].anumber,m_user[id].usertype);
    }

    //Get applicant type 
    function getusertype(uint256 id) view public returns(bytes32,bytes32) {
     return(m_user[id].pass,m_user[id].usertype);     
    }

     function getapplied(uint256 pkey) view public returns(uint256,uint256,bytes32) {
     return(m_applied[pkey].jobid,m_applied[pkey].userid,m_applied[pkey].jname);     
     }


    //Fetch applicant rating 
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
