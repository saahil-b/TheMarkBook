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
    
    // sprint 4
    
    func testAddTermChangesTermsArray() {
        // initialises division for testing
        let div = Division(name: "D1")

        // records old length of students array
        let oldLength = div.terms.count
        
        // adds term to be removed
        div.addTerm()
        
        // checks that length of students array has increased by 1
        XCTAssertEqual(oldLength + 1, div.terms.count)
    }
    
    func testRemoveTermChangesTermsArray() {
        // initialises division for testing
        let div = Division(name: "D1")

        // adds student to be removed
        div.addTerm()


        // records old length of students array
        let oldLength = div.terms.count

        // adds new student to students array
        div.removeTerm(index: 0)

        // checks that length of students array has increased by 1
        XCTAssertEqual(oldLength - 1, div.students.count)
    }
    
    
    func testAddAssignmentAssignsUniqueID() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        div.addTerm()

        // adds new students to students array
        div.addAssignment(name: "A", date: Date(), topic: "", termIndex: 0)
        div.addAssignment(name: "B", date: Date(), topic: "", termIndex: 0)

        // checks that length of students array has increased by 1
        XCTAssertNotEqual(div.returnAllAssignments()[0].id, div.returnAllAssignments()[1].id)
    }
    
    func testAddTermAssignsUniqueID() {
        // initialises division for testing
        let div = Division(name: "D1")

        // adds new students to students array
        div.addTerm()
        div.addTerm()

        // checks that length of students array has increased by 1
        XCTAssertNotEqual(div.terms[0].id, div.terms[1].id)
    }
    
    func testAddStudentAssignsCorrectMarkValue() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // adds term to which assignment can be added
        div.addTerm()
        
        // adds 5 new assignments
        for _ in 0...5 {
            div.addAssignment(name: "A", date: Date(), topic: "Wow!", termIndex: 0)
        }
        
        // adds a new student
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
        
        // stores the mark that should be assigned
        let defaultMark = Mark.returnDefaultValue()
        
        // ensures that value assigned is correct
        for assignment in div.returnAllAssignments() {
            if let currentMark = div.students[0].marks[assignment.id] {
                XCTAssertEqual(currentMark.value, defaultMark.value)
            }
        }
    }
    
    func testAddStudentAssignsCorrectMarkExcuse() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // adds term to which assignment can be added
        div.addTerm()
        
        // adds 5 new assignments
        for _ in 0...5 {
            div.addAssignment(name: "A", date: Date(), topic: "Wow!", termIndex: 0)
        }
        
        // adds a new student
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
        
        // stores the mark that should be assigned
        let defaultMark = Mark.returnDefaultValue()
        
        // ensures that excuse assigned is correct
        for assignment in div.returnAllAssignments() {
            if let currentMark = div.students[0].marks[assignment.id] {
                XCTAssertEqual(currentMark.excuse, defaultMark.excuse)
            }
        }
    }
    
    func testAddStudentAssignsCorrectMarkReceived() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // adds term to which assignment can be added
        div.addTerm()
        
        // adds 5 new assignments
        for _ in 0...5 {
            div.addAssignment(name: "A", date: Date(), topic: "Wow!", termIndex: 0)
        }
        
        // adds a new student
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
        
        // stores the mark that should be assigned
        let defaultMark = Mark.returnDefaultValue()
        
        // ensures that excuse assigned is correct
        for assignment in div.returnAllAssignments() {
            if let currentMark = div.students[0].marks[assignment.id] {
                XCTAssertEqual(currentMark.received, defaultMark.received)
            }
        }
    }
    
    func testReturnAllAssignmentsReturnsEveryAssignment() {
        // initialises division for testing
        let div = Division(name: "D1")
        
        // variable to keep track of no. assignments
        var count = 0
        
        // adds 5 new terms
        for i in 0...5 {
            div.addTerm()
            
            // adds 3 new assignments to each term
            for _ in 0...3 {
                div.addAssignment(name: "A", date: Date(), topic: "Wow!", termIndex: i)
                // adds one to count for every assignment added
                count += 1
            }
        }
        
        // checks that number of assignments returned is same as count
        XCTAssertEqual(count, div.returnAllAssignments().count)
    }
     
    
    let x = """
        func addAssignment(name: String, date: Date, topic: String, termIndex: Int) {
            
            let id = assignmentIDManager.generateNewID()
            
            terms[termIndex].addAssignment(name: name, date: date, topic: topic, id: id )
            
            for student in students {
                student.marks[id] = Mark.returnDefaultValue()
            }
            
        }
        
        func addStudent(name: String, dateOfBirth: Date, contactInfo: String) {
            
            let assignments = self.returnAllAssignments()
            
            let sID = studentIDManager.generateNewID()
            
            let student = Student(name: name, dateOfBirth: dateOfBirth, contactInfo: contactInfo, id: sID, assignments: assignments)
            
            for assignment in assignments {
                var marks = assignment.marks
                
                marks[sID] = Mark.returnDefaultValue()
                    
                assignment.updateMarks(marks: marks)
            }
            
            self.students.append(student)
        }
        
        func removeStudent(index: Int) {
            
            let assignments = self.returnAllAssignments()
            
            for assignment in assignments {
                assignment.marks.removeValue(forKey: self.students[index].id)
            }
            
            self.students.remove(at: index)
            
        }
        
        func moveStudent(fromOffsets: IndexSet, toOffset: Int) {
            self.students.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
        
        func addTerm() {
            let term = Term(name: "New Term", id: termIDManager.generateNewID())
            
            self.terms.append(term)
            
        }
        
        func removeTerm(index: Int) {
            self.terms.remove(at: index)
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
