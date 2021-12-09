//
//  DivisionTests.swift
//  TheMarkBookTests
//
//  Created by Bahadur, Saahil (PAH) on 18/11/2021.
//

import XCTest
@testable import TheMarkBook

class DivisionTests: XCTestCase {
    
    func testInitAssignsCorrectName() {
        // defines name to be assigned to division
        let name = "Jammy Grammy Lammy"
        
        // initialises division for testing
        let div = Division(name: name)
        
        // checks whether names are the same
        XCTAssertEqual(name, div.name)
        
    }
    
    func testInitAddsEmptyTerms() {
        // initialises division for testing
        let div = Division(name: "F'huppa F'huppa")
        
        // checks whether names are the same
        XCTAssertEqual(div.terms.count, 0)
        
    }
    
    func testInitAddsEmptyStudents() {
        // initialises division for testing
        let div = Division(name: "Berlin Stereo")
        
        // checks whether names are the same
        XCTAssertEqual(div.students.count, 0)
        
    }
    
    func testAddStudentChangesStudentArray() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // records old length of students array
        let oldLength = div.students.count
        
        // adds new student to students array
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(oldLength + 1, div.students.count)
        
    }
    
    func testAddStudentAddsCorrectName() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // creates dummy name
        let name = "Eo Eo Lepp"
        
        // adds new student to students array
        div.addStudent(name: name, dateOfBirth: Date(), contactInfo: "gmail")
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(name, div.students[0].name)
        
    }
    
    func testAddStudentAddsCorrectDOB() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // creates dummy DOB
        let dateOfBirth = Date()
        
        // adds new student to students array
        div.addStudent(name: "C'Yepp", dateOfBirth: dateOfBirth, contactInfo: "gmail")
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(dateOfBirth, div.students[0].dateOfBirth)
        
    }
    
    func testAddStudentAddsCorrectContactInfo() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // creates dummy contact info
        let contactInfo = "leMonica@gmail.co.uk"
        
        // adds new student to students array
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: contactInfo)
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(contactInfo, div.students[0].contactInfo)
        
    }
    
    func testAddStudentAssignsUniqueID() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // adds new students to students array
        div.addStudent(name: "leStraypeck", dateOfBirth: Date(), contactInfo: "gmail")
        div.addStudent(name: "deGrespin", dateOfBirth: Date(), contactInfo: "gmail")
        
        // checks that length of students array has increased by 1
        XCTAssertNotEqual(div.students[0].id, div.students[1].id)
    }
    
    func testRemoveStudentAffectsStudentArray() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // adds student to be removed
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")

        
        // records old length of students array
        let oldLength = div.students.count
        
        // adds new student to students array
        div.removeStudent(index: 0)
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(oldLength - 1, div.students.count)
    }
    
    func testMoveStudentMovesStudent() {
        // initialises division for testing
        let div = Division(name: "D1")

        for i in 0...3 {
            // adds students to division
            div.addStudent(name: "S\(i)", dateOfBirth: Date(), contactInfo: "")
        }
        
        // records IDs for testing
        let firstID = div.students[0].id
        let secondID = div.students[1].id
        let thirdID = div.students[2].id
        
        // carries out move
        div.moveStudent(fromOffsets: IndexSet(integer: 0), toOffset: 2)
        
        // checks that students have been moved
        XCTAssertEqual(div.students[0].id, secondID)
        XCTAssertEqual(div.students[1].id, firstID)
        XCTAssertEqual(div.students[2].id, thirdID)
    }
    
    func testAddTermChangesTermArray() {
        // initialises division for testing
        let div = Division(name: "D1")

        // records old length of students array
        let oldLength = div.terms.count
        
        // adds term to be removed
        div.addTerm()
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(oldLength + 1, div.terms.count)
    }
    
//    func testRemoveTermAffectsTermsArray() {
//        // initialises division for testing
//        let div = Division(name: "D1")
//
//        // adds student to be removed
//        div.addTerm()
//
//
//        // records old length of students array
//        let oldLength = div.terms.count
//
//        // adds new student to students array
//        div.removeTerm(index: 0)
//
//        // checks that length of students array has increased by 1
//        XCTAssertEqual(oldLength - 1, div.students.count)
//    }
    
//    func testMoveTermMovesTerm() {
//        // initialises division for testing
//        let div = Division(name: "D1")
//
//        for _ in 0...3 {
//            // adds students to division
//            div.addTerm()
//        }
//
//        // records IDs for testing
//        let firstID = div.terms[0].id
//        let secondID = div.terms[1].id
//        let thirdID = div.terms[2].id
//
//        // carries out move
//        div.moveTerm(fromOffsets: IndexSet(integer: 0), toOffset: 2)
//
//        // checks that students have been moved
//        XCTAssertEqual(div.terms[0].id, secondID)
//        XCTAssertEqual(div.terms[1].id, firstID)
//        XCTAssertEqual(div.students[2].id, thirdID)
//    }
    
    
//    func testAddAssignmentAssignsUniqueID() {
//        // initialises division for testing
//        let div = Division(name: "D1")
//
//        // adds new students to students array
//        div.addAssignment(name: "A", date: Date(), topic: "")
//        div.addAssignment(name: "B", date: Date(), topic: "")
//
//        // checks that length of students array has increased by 1
//        XCTAssertNotEqual(div.returnAllAssignments()[0].id, div.returnAllAssignments()[1].id)
//    }
    
//    func testAddTermAssignsUniqueID() {
//        // initialises division for testing
//        let div = Division(name: "D1")
//
//        // adds new students to students array
//        div.addTerm()
//        div.addTerm()
//
//        // checks that length of students array has increased by 1
//        XCTAssertNotEqual(div.terms()[0].id, div.terms()[1].id)
//    }
    
//    func testAddStudentAssignsCorrectMarkValue() {
//        let div = Division(name: "D1")
//
//        for _ in 0...5 {
//            div.addAssignment(name: "A", date: Date(), topic: "Wow!")
//        }
//
//        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
//
//        let defaultMark = Mark.returnDefaultValue()
//
//        for assignment in div.returnAllAssignments() {
//            if let currentMark = div.students[0].marks[assignment.id] {
//                XCTAssertEqual(currentMark.value, defaultMark.value)
//            }
//        }
//
//    }
    
//    func testAddStudentAssignsCorrectMarkExcuse() {
//        let div = Division(name: "D1")
//
//        for _ in 0...5 {
//            div.addAssignment(name: "A", date: Date(), topic: "Wow!")
//        }
//
//        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
//
//        let defaultMark = Mark.returnDefaultValue()
//
//        for assignment in div.returnAllAssignments() {
//            if let currentMark = div.students[0].marks[assignment.id] {
//                XCTAssertEqual(currentMark.excuse, defaultMark.excuse)
//            }
//        }
//
//    }
    
//    func testAddStudentAssignsCorrectMarkReceived() {
//        let div = Division(name: "D1")
//
//        for _ in 0...5 {
//            div.addAssignment(name: "A", date: Date(), topic: "Wow!")
//        }
//
//        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
//
//        let defaultMark = Mark.example
//
//        for assignment in div.returnAllAssignments() {
//            if let currentMark = div.students[0].marks[assignment.id] {
//                XCTAssertEqual(currentMark.received, defaultMark.received)
//            }
//        }
//
//    }
     
    
    let x = """
    func addAssignment(name: String, date: Date, topic: String) {
        
        let id = assignmentIDManager.generateNewID()
        
        terms[terms.count - 1].addAssignment(name: name, date: date, topic: topic, id: id )
        
        for student in students {
            student.marks[id] = Mark(value: nil, excuse: "Excused", received: false)
        }
        
    }
    
    func addStudent(name: String, dateOfBirth: Date, contactInfo: String) {
        
        let assignments = self.returnAllAssignments()
        
        let sID = studentIDManager.generateNewID()
        
        let student = Student(name: name, dateOfBirth: dateOfBirth, contactInfo: contactInfo, id: sID, assignments: assignments)
        
        for assignment in assignments {
            assignment.marks[sID] = Mark(value: nil, excuse: "Excused", received: false)
        }
        
        self.students.append(student)
    }
    
    func removeStudent(index: Int) {
        self.students.remove(at: index)
    }
    
    func moveStudent(fromOffsets: IndexSet, toOffset: Int) {
        self.students.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addTerm() {
        let term = Term(name: "New Term", id: termIDManager.generateNewID())
        
        self.terms.append(term)
        
    }
    
    func returnAllAssignments() -> [Assignment] {
        
        var assignments: [Assignment] = []
        
        for term in terms {
            for assignment in term.assignments {
                assignments.append(assignment)
            }
        }
        
        return assignments
    }
    """
    
    
}
