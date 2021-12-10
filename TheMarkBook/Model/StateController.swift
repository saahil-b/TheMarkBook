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
    
    @Published var refresh: String
    
    init() {
        self.currentDivisions = []
        self.archivedDivisions = []
        self.refresh = ""
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
    
    static func createNewDivision(name: String) -> Division {
        let division = Division(name: name)
        
        for i in 0...3 {
            division.addTerm()
            
            for j in 0...3 {
                division.addAssignment(name: "A\(j)", date: Date(), topic: "good topic", termIndex: i)
            }
            
        }
        
        for i in 0...4 {
            division.addStudent(name: "S\(i)", dateOfBirth: Date(), contactInfo: "gmail.fmail@email.com")
        }
        
        return division
    }
    
    static func createStateController() -> StateController{
        let state = StateController()
        
        for i in 1...3 {
            
            let div = createNewDivision(name: "A\(i)")
            
            
            state.addToCurrentDivisions(division: div)
            state.archiveDivision(index: 0)
        }
        
        
        for i in 1...6 {
            
            let div = createNewDivision(name: "C\(i)")
            
            state.addToCurrentDivisions(division: div)
        }
        
        return state
        
    }
    
    static let example = createStateController()
    
    #endif
    
}
