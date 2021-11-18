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
    
    func testStateControllerMoveCurrentDivision(){
        let state = StateController()
        let firstDiv = Division(name: "1")
        let secondDiv = Division(name: "2")
        
        state.addToCurrentDivisions(division: firstDiv)
        state.addToCurrentDivisions(division: secondDiv)
        
        state.moveCurrentDivision(fromOffsets: IndexSet(integer: 0), toOffset: 2)
        
        XCTAssertEqual(state.currentDivisions[0].name, "2")
        XCTAssertEqual(state.currentDivisions[1].name, "1")
    }
    
    func testStateControllerDeleteFromCurrentDivisions(){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        state.deleteFromCurrentDivisions(index: 0)
        
        XCTAssertEqual(state.currentDivisions.count, 0)
    }
    
    func testStateControllerAddToArchivedDivisions(){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToArchivedDivisions(division: division)
        
        XCTAssertEqual(state.archivedDivisions.count, 1)
    }
    
    func testStateControllerDeleteFromArchivedDivisions(){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToArchivedDivisions(division: division)
        state.deleteFromArchivedDivisions(index: 0)
        
        XCTAssertEqual(state.archivedDivisions.count, 0)
    }
    
    func testStateControllerArchiveDivision(){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        state.archiveDivision(index: 0)
        
        XCTAssertEqual(state.currentDivisions.count, state.archivedDivisions.count - 1)
    }
    
    func testStateControllerRecoverDivision(){
        let state = StateController()
        let division = Division(name: "VCX-1")
        
        state.addToCurrentDivisions(division: division)
        state.archiveDivision(index: 0)
        state.recoverDivision(index: 0)
        
        XCTAssertEqual(state.currentDivisions.count - 1, state.archivedDivisions.count)
    }

}
