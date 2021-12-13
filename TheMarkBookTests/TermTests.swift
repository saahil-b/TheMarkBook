//
//  TermTests.swift
//  TheMarkBookTests
//
//  Created by Rakesh Bahadur on 12/12/2021.
//

import XCTest
@testable import TheMarkBook

class TermTests: XCTestCase {
    
    func testAddAssignmentChangesAssignmentsArray() {
        // initialises term for testing
        let term = Term(name: "T1", id: 0)
        
        // records original length of assignments
        let oldLength = term.assignments.count
        
        // calls function we are testing
        term.addAssignment(name: "A", date: Date(), topic: "", id: 0)
        
        // checks that length of assignments has increased by 1
        XCTAssertEqual(oldLength + 1, term.assignments.count)
    }
    
    func testAddAssignmentAddsCorrectName() {
        // initialises term for testing
        let term = Term(name: "T1", id: 0)
        
        // records name value given to assignment
        let name = "Test"
        
        // calls function we are testing
        term.addAssignment(name: name, date: Date(), topic: "", id: 0)
        
        // checks that assignment name and assigned name are the same
        XCTAssertEqual(name, term.assignments[0].name)
    }
    
    func testAddAssignmentAddsCorrectDate() {
        // initialises term for testing
        let term = Term(name: "T1", id: 0)
        
        // records date value given to assignment
        let date = Date()
        
        // calls function we are testing
        term.addAssignment(name: "A", date: date, topic: "", id: 0)
        
        // checks that assignment date and assigned date are the same
        XCTAssertEqual(date, term.assignments[0].date)
    }
    
    func testAddAssignmentAddsCorrectTopic() {
        // initialises term for testing
        let term = Term(name: "T1", id: 0)
        
        // records topic value given to assignment
        let topic = "Test"
        
        // calls function we are testing
        term.addAssignment(name: "A", date: Date(), topic: topic, id: 0)
        
        // checks that assignment topic and assigned topic are the same
        XCTAssertEqual(topic, term.assignments[0].topic)
    }
    
    func testAddAssignmentAddsCorrectID() {
        // initialises term for testing
        let term = Term(name: "T1", id: 0)
        
        // records id value given to assignment
        let id = 1
        
        // calls function we are testing
        term.addAssignment(name: "A", date: Date(), topic: "", id: 1)
        
        // checks that assignment ID and assigned ID are the same
        XCTAssertEqual(id, term.assignments[0].id)
    }
    
    func testMoveAssignmentMovesAssignment() {
        // initialises term for testing
        let term = Term(name: "T1", id: 0)
        
        // adds templates to assignments
        term.addAssignment(name: "A0", date: Date(), topic: "", id: 0)
        term.addAssignment(name: "A1", date: Date(), topic: "", id: 1)
        term.addAssignment(name: "A2", date: Date(), topic: "", id: 2)
        
        // carries out operation
        term.moveAssignment(fromOffsets: IndexSet(integer: 0), toOffset: 2)
        
        // checks that assignments are in the correct place
        XCTAssertEqual(term.assignments[0].name, "A1")
        XCTAssertEqual(term.assignments[1].name, "A0")
        XCTAssertEqual(term.assignments[2].name, "A2")
    }
    
    func testRemoveAssignmentChangesAssignmentArray() {
        // initialises division for testing
        let term = Term(name: "T1", id: 0)
        
        // records length of array before addition
        let oldLength = term.assignments.count
        
        // adds assignment to be removed
        term.addAssignment(name: "A0", date: Date(), topic: "", id: 0)
        
        // carries out operation
        term.removeAssignment(index: 0)

        // ensures previous length is restored
        XCTAssertEqual(term.assignments.count, oldLength)
    }
    
    let x = """
    func addAssignment(name: String, date: Date, topic: String, id: Int) {
        let assignment = Assignment(name: name, date: date, topic: topic, id: id)
        self.assignments.append(assignment)
    }
    
    func moveAssignment(fromOffsets: IndexSet, toOffset: Int) {
        self.assignments.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func removeAssignment(index: Int) {
        self.assignments.remove(at: index)
    }
    """
}
