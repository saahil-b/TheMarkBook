//
//  AssignmentTests.swift
//  TheMarkBookTests
//
//  Created by Rakesh Bahadur on 18/01/2022.
//

import XCTest
@testable import TheMarkBook

class AssignmentTests: XCTestCase {
 
    func testUpdateMarksUpdatesMarksCorrectly() {
        // initialise assignment for testing
        let assignment = Assignment(name: "A", date: Date(), topic: "topic", id: 0)
        
        var marks: [Int:Mark] = [:]
        
        for i in 0...5 {
            marks[i] = Mark(value: Double(Int.random(in: 10...50)), excuse: nil, received: true)
        }
            
        //let total = marks.values.reduce(0, +)
        
        assignment.updateMarks(marks: marks)
        
        for i in 0...marks.count {
            XCTAssertEqual(marks[i]?.value, assignment.marks[i]?.value)
        }
    }
    
//    func testUpdateMarksUpdatesMarksCorrectly() {
//        // initialise assignment for testing
//        let assignment = Assignment(name: "A", date: Date(), topic: "topic", id: 0)
//
//        var marks: [Int:Mark] = [:]
//        
//        for i in 0...5 {
//            marks[i] = Mark(value: Double(Int.random(in: 10...50)), excuse: nil, received: true)
//        }
//
//        //let total = marks.values.reduce(0, +)
//
//        assignment.updateMarks(marks: marks)
//
//        for i in 0...marks.count {
//            XCTAssertEqual(marks[i]?.value, assignment.marks[i]?.value)
//        }
//    }
    
}
