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
    
    func addToCurrentDivisions(division : Division){
        currentDivisions.append(division)
    }
    
    func deleteFromCurrentDivisions(index: Int){
        currentDivisions.remove(at: index)
    }
    
    func moveCurrentDivision(fromOffsets: IndexSet, toOffset: Int) {
        currentDivisions.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addToArchivedDivisions(division : Division){
        archivedDivisions.insert(division, at: 0)
    }
    
    func deleteFromArchivedDivisions(index: Int){
        archivedDivisions.remove(at: index)
    }
    
    func archiveDivision(index: Int){
        let division = currentDivisions[index]
        addToArchivedDivisions(division: division)
        deleteFromCurrentDivisions(index: index)
    }
    
    func recoverDivision(index: Int){
        let division = archivedDivisions[index]
        addToCurrentDivisions(division: division)
        deleteFromArchivedDivisions(index: index)
    }
    
    func save() {
        // save to local storage
    }
    
    #if DEBUG
    
    static func createStateController() -> StateController{
        let state = StateController()
        
        state.addToCurrentDivisions(division: Division(name: "A1"))
        state.archiveDivision(index: 0)
        state.addToCurrentDivisions(division: Division(name: "A2"))
        state.archiveDivision(index: 0)
        
        state.addToCurrentDivisions(division: Division(name: "C1"))
        state.addToCurrentDivisions(division: Division(name: "C2"))
        state.addToCurrentDivisions(division: Division(name: "C3"))
        state.addToCurrentDivisions(division: Division(name: "C4"))
        state.addToCurrentDivisions(division: Division(name: "C5"))
        state.addToCurrentDivisions(division: Division(name: "C6"))
        
        return state
    }
    
    static let example = createStateController()
    #endif
    
}
