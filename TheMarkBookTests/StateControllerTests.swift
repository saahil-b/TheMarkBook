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
        // initialises new state controller
        let state = StateController()

        // checks that currentDivisions is empty
        XCTAssertEqual(state.currentDivisions.count, 0)
    }

    func testStateControllerInitAddsEmptyArchivedDivisons(){
        // initialises new state controller
        let state = StateController()

        // checks that archivedDivisions is empty
        XCTAssertEqual(state.archivedDivisions.count, 0)
    }

    func testStateControllerAddToCurrentDivisionsAddsDivision(){
        // initialises new state controller
        let state = StateController()

        // creates new division to add to currentDivisions
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // ensures that division is added
        XCTAssertEqual(state.currentDivisions.count, 1)
    }

    func testStateControllerAddToCurrentDivisionsAddsCorrectName(){
        // initialises new state controller
        let state = StateController()

        // creates new division to add to currentDivisions
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // ensures that name of division in array and name assigned to division are equal
        XCTAssertEqual(state.currentDivisions[0].name, "VCX-1")
    }

    func testStateControllerMoveCurrentDivisionMovesDivision(){
        // initialises new state controller
        let state = StateController()

        // creates division templates to add to currentDivisions
        let firstDiv = Division(name: "1")
        let secondDiv = Division(name: "2")
        let thirdDiv = Division(name: "3")

        // adds templates to currentDivisions
        state.addToCurrentDivisions(division: firstDiv)
        state.addToCurrentDivisions(division: secondDiv)
        state.addToCurrentDivisions(division: thirdDiv)

        // carries out operation
        state.moveCurrentDivision(fromOffsets: IndexSet(integer: 0), toOffset: 2)

        // checks that divisions are in the same place
        XCTAssertEqual(state.currentDivisions[0].name, "2")
        XCTAssertEqual(state.currentDivisions[1].name, "1")
        XCTAssertEqual(state.currentDivisions[2].name, "3")
    }

    func testStateControllerDeleteFromCurrentDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // carries out deletion from currentDivisions
        state.deleteFromCurrentDivisions(index: 0)

        // checks that div has been removed
        XCTAssertEqual(state.currentDivisions.count, 0)
    }

    func testStateControllerAddToArchivedDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds division to archivedDivisions
        state.addToArchivedDivisions(division: division)

        // checks that a division has been added
        XCTAssertEqual(state.archivedDivisions.count, 1)
    }

    func testStateControllerDeleteFromArchivedDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds template to archivedDivisions
        state.addToArchivedDivisions(division: division)

        // removes template from archivedDivisions
        state.deleteFromArchivedDivisions(index: 0)

        // checks that div has been removed
        XCTAssertEqual(state.archivedDivisions.count, 0)
    }

    func testStateControllerArchiveDivisionRemovesFromCurrentDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // archives division
        state.archiveDivision(index: 0)

        // checks that division has been removed from currentDivisions
        XCTAssertEqual(state.currentDivisions.count, 0)
    }

    func testStateControllerArchiveDivisionAddsToArchivedDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // archives division
        state.archiveDivision(index: 0)

        // checks that division has been removed from currentDivisions
        XCTAssertEqual(state.archivedDivisions.count, 1)
    }

    func testStateControllerRecoverDivisionRemovesFromArchivedDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // archives division
        state.archiveDivision(index: 0)

        // recovers division
        state.recoverDivision(index: 0)

        // checks that division is removed from archivedDivisions
        XCTAssertEqual(state.archivedDivisions.count, 0)
    }

    func testStateControllerRecoverDivisionAddsToCurrentDivisions(){
        // initialises new state controller
        let state = StateController()

        // creates division template to use for testing
        let division = Division(name: "VCX-1")

        // adds division to currentDivisions
        state.addToCurrentDivisions(division: division)

        // archives division
        state.archiveDivision(index: 0)

        // recovers division
        state.recoverDivision(index: 0)

        // checks that division is added to currentDivisions
        XCTAssertEqual(state.currentDivisions.count, 1)
    }

}
