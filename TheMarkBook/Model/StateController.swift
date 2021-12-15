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
        
        let termNames = ["Autumn", "Winter", "Summer"]
        let topics = ["geometry", "calculus", "complex numbers", "mechanics"]
        
        let division = Division(name: name)
        
        for i in 0...2 {
            division.addTerm()
            
            division.terms[i].name = termNames[i]
            
            for j in 0...3 {
                
                var components = DateComponents()
                components.year = 2021
                components.month = Int.random(in: 1...12)
                components.day = Int.random(in: 1...28)
                let date = Calendar(identifier: .gregorian).date(from: components) ?? Date()
                
                division.addAssignment(assignment: Assignment(name: "A\(j)", date: date, topic: topics[Int.random(in: 0..<topics.count)], id: division.assignmentIDManager.generateNewID()), termIndex: i)
                
                division.terms[i].assignments[j].maximumMark = 100
            }
            
        }
        
        let studentNames = ["Shri Shri Sampta Jhalangar", "Horus of the Eastern Seaboard", "Styrofoam pocketwatch", "Jhabnesh Jhalangar"]
        
        let excuses = ["Overdue", "Excused"]
        
        for i in 0...3 {
            
            var components = DateComponents()
            components.year = Int.random(in: 2003...2004)
            components.month = Int.random(in: 1...12)
            components.day = Int.random(in: 1...28)
            let date = Calendar(identifier: .gregorian).date(from: components) ?? Date()
                        
            division.addStudent(name: studentNames[i], dateOfBirth: date, contactInfo: "gmail.fmail@email.com")
            
            for (_, mark) in division.students[i].marks {
                
                if Int.random(in: 0...7) == 0 {
                    mark.received = false
                    mark.excuse = excuses[Int.random(in: 0...1)]
                    
                } else {
                    let value = Double(Int.random(in: 0...100))
                    mark.received = true
                    mark.value = value
                }
            }
            
            division.updateAssignmentsWithStudentMarkChanges(marks: division.students[i].marks, studentID: division.students[i].id)
            
        }
        
        return division
    }
    
    static func createStateController() -> StateController{
        let state = StateController()
        
        let archiveNames = ["MCW-2", "VCX-1", "VCZ-2"]
        
        for i in 0...2 {
            
            let div = createNewDivision(name: archiveNames[i])
            
            
            state.addToCurrentDivisions(division: div)
            state.archiveDivision(index: 0)
        }
        
        let currentNames = ["VBZ-2", "VCY-3",  "MCZ-1", "PBY-2", "SDN-4"]
        
        for i in 0...4 {
            
            let div = createNewDivision(name: currentNames[i])
            
            state.addToCurrentDivisions(division: div)
        }
        
        return state
        
    }
    
    static let example = createStateController()
    
    #endif
    
}
