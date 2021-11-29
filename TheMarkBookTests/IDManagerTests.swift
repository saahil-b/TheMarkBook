//
//  IDManagerTests.swift
//  TheMarkBookTests
//
//  Created by Bahadur, Saahil (PAH) on 29/11/2021.
//

import XCTest
@testable import TheMarkBook

class IDManagerTests: XCTestCase {
    
    func testInitAssignsCorrectMaxID() {
        let IDM = IDManager()
        
        XCTAssertEqual(0, IDM.maxID)
    }
    
    func testGenerateNewIDChangesMaxID() {
        let IDM = IDManager()
        
        let oldMaxID = IDM.maxID
        
        let _ = IDM.generateNewID()
        
        XCTAssertNotEqual(oldMaxID, IDM.maxID)
    }
    
    func testGenerateNewIDReturnsUniqueID() {
        let IDM = IDManager()
        
        let a = IDM.generateNewID()
        let b = IDM.generateNewID()
        
        XCTAssertNotEqual(a, b)
    }
    
}
