//
//  StateController.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import Foundation

class StateController: ObservableObject {
    @Published var currentDivisions : [Division]
    @Published var archivedDivisions : [Division]
    
    init() {
        self.currentDivisions = []
        self.archivedDivisions = []
    }
    
    func addNewDivision(division : Division){
        currentDivisions.append(division)
    }
    
    func deleteFromCurrentDivisions(index: Int){
        currentDivisions.remove(at: index)
    }
    
    func archiveDivision(index: Int){
        let division = currentDivisions[index]
        // find division in currentDivisions
        // remove from currentDivisions
        archivedDivisions.append(division)
    }
    
    func recoverDivision(index: Int){
        let division = currentDivisions[index]
        // find division in archivedDivisions
        // remove from archivedDivisions
        currentDivisions.append(division)
    }
    
    func deleteFromArchivedDivisions(index: Int){
        archivedDivisions.remove(at: index)
    }
    
    func save() {
        // save to local storage
    }
    
    #if DEBUG
    
    static func createStateController() -> StateController{
        let state = StateController()
        state.addNewDivision(division: Division(name: "VCX-1"))
        state.archiveDivision(index: 0)
        state.addNewDivision(division: Division(name: "VCX-2"))
        state.archiveDivision(index: 0)
        state.addNewDivision(division: Division(name: "VCX-3"))
        state.addNewDivision(division: Division(name: "VCX-4"))
        
        return state
    }
    
    static let example = createStateController()
    #endif
    
}
