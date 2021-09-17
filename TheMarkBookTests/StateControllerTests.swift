//
//  StateControllerTests.swift
//  TheMarkBookTests
//
//  Created by Bahadur, Saahil (PAH) on 17/09/2021.
//

import XCTest
@testable import TheMarkBook

class StateControllerTests: XCTestCase {
    
    func testStateControllerInitAddsEmptyCurrentDivisons(){
        let state = StateController()
        
        XCTAssertEqual(state.currentDivisions.count, 0)
    }
    
    func testStateControllerInitAddsEmptyArchivedDivisons(){
        let state = StateController()
        
        XCTAssertEqual(state.currentDivisions.count, 0)
    }
    
    func testStateControllerAddToCurrentDivisions(){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        
        XCTAssertEqual(state.currentDivisions.count, 1)
    }
    
    func testStateControllerDeleteFromCurrentDivisions(index: Int){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        state.deleteFromCurrentDivisions(index: 0)
        
        XCTAssertEqual(state.currentDivisions.count, 0)
    }
    
    func testStateControllerAddToArchivedDivisions(division : Division){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToArchivedDivisions(division: division)
        
        XCTAssertEqual(state.archivedDivisions.count, 1)
    }
    
    func testStateControllerDeleteFromArchivedDivisions(index: Int){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToArchivedDivisions(division: division)
        state.deleteFromArchivedDivisions(index: 0)
        
        XCTAssertEqual(state.archivedDivisions.count, 0)
    }
    
    func testStateControllerArchiveDivision(index: Int){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        state.archiveDivision(index: 0)
        
        XCTAssertEqual(state.currentDivisions.count, state.archivedDivisions.count - 1)
    }
    
    func testStateControllerRecoverDivision(index: Int){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        state.archiveDivision(index: 0)
        state.recoverDivision(index: 0)
        
        XCTAssertEqual(state.currentDivisions.count - 1, state.archivedDivisions.count)
    }
    

}
