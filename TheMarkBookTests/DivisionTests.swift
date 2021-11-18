//
//  DivisionTests.swift
//  TheMarkBookTests
//
//  Created by Bahadur, Saahil (PAH) on 18/11/2021.
//

import XCTest
@testable import TheMarkBook

class DivisionTests: XCTestCase {
    
    func testAddStudentChangesStudentArray() {
        let div = Division(name: "D1")
        let oldLength = div.students.count
        
        div.addStudent(name: "Test", dateOfBirth: Date(), contactInfo: "gmail")
        
        XCTAssertEqual(oldLength + 1, div.students.count)
        
    }
    
    
}
