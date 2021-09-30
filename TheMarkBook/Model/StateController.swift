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
    
    //only done through archiving
    func deleteFromCurrentDivisions(index: Int){
        currentDivisions.remove(at: index)
    }
    
    func moveCurrentDivision(fromOffsets: IndexSet, toOffsets: Int) {
        currentDivisions.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
    
    //only done through archiving
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
        
        state.addToCurrentDivisions(division: Division(name: "VCX-1"))
        state.archiveDivision(index: 0)
        state.addToCurrentDivisions(division: Division(name: "VCX-2"))
        state.archiveDivision(index: 0)
        
        state.addToCurrentDivisions(division: Division(name: "VCX-3"))
        state.addToCurrentDivisions(division: Division(name: "VCX-4"))
        
        return state
    }
    
    static let example = createStateController()
    #endif
    
}
