//SPDX-License-Identifier: MIT
pragma solidity 0.4.18;
pragma experimental ABIEncoderV2;

contract MondkapjesMelderStorage {
    /* Initial Structs */
    struct Report {
        string dateTime;
        address reportedBy;
    }

    struct Student {
        uint studentId;
        uint timesReported;
        string firstName;
        string lastName;
        string classId;
        mapping(string=>Report) reports;
        string[] report_result;
    }

    /* Intial Arrays */
    mapping(uint=>Student) students; //All students
    string[] student_result; //Student Names Array

    mapping(address=>bool) isAdmin; //Insert reporter wallet address -> output if is admin

    /* Main Functions */

    /* Setter functions */
    function addStudent(uint _studentId, string memory _firstName, string memory _lastName, string memory _classId) public {
        var result 
          = students[_studentId];
  
        result.firstName = _firstName;
        result.lastName = _lastName;
        result.timesReported = 0;
        result.classId = _classId;


        student_result.push(_firstName);
    }

    function reportStudent(uint _studentId, string memory _dateTime) public {
        var resultStudent = students[_studentId];
        var resultReport = resultStudent.reports[_dateTime];

        resultStudent.timesReported++;

        resultReport.dateTime = _dateTime;
        resultReport.reportedBy = msg.sender;

        resultStudent.report_result.push(_dateTime) -1;
    }

    function setAdmin(address _address) public {
        isAdmin[_address] = true;
    }

    /* Getter functions */
    function getStudentInfo(uint _studentId) public view returns (string firstName, string lastName, string classId, uint timesReported) {
        var result = students[_studentId];
        return (result.firstName, result.lastName, result.classId, result.timesReported);
    }

    function getReports(uint _studentId) public view returns (string[]) {
        var resultStudent = students[_studentId];
        return resultStudent.report_result;
    }

    function getStudents() public view returns (string[]) {
        return student_result;
    }

    function checkIfUserAdmin() public view returns (bool) {
        return isAdmin[msg.sender];
    }
}
