//
//  StateController.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import Foundation

class StateController: ObservableObject, Codable {
    
    // general app
    
    @Published var currentDivisions : [Division]
    @Published var archivedDivisions : [Division]
    
    var divisionIDManager: IDManager
        
    init() {
        self.currentDivisions = []
        self.archivedDivisions = []
        self.divisionIDManager = IDManager()
        loadFromFile()
    }
    
    // adding/removing divisions
    
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
    
    // saving division data
    
    func findDivisionIndexByID(id: Int) -> Int? {
        // search through current divisions
        for i in 0..<currentDivisions.count {
            // checks if id is correct
            if currentDivisions[i].id == id {
                // returns index
                return i
            }
        }
        // returns nil if division not found
        return nil
    }
    
    func findDivisionIndexInArchive(id: Int) -> Int? {
        // search through archived divisions
        for i in 0..<archivedDivisions.count {
            // checks if id is correct
            if archivedDivisions[i].id == id {
                // returns index
                return i
            }
        }
        // returns nil if division not found
        return nil
    }
    
    func saveDivisionData(division: Division, id: Int) {
        // finds index of division
        if let index = findDivisionIndexByID(id: id) {
            // replaces division with new division data
            currentDivisions[index] = division
        }
    }
    
    func renameDivision(name: String, id: Int) {
        // finds index of division
        if let index = findDivisionIndexByID(id: id) {
            // changes division name in state
            currentDivisions[index].name = name
        }
    }
    
    static var initial = StateController()
        
    
    // local storage
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        currentDivisions = try container.decode([Division].self, forKey: .currentDivisions)
        archivedDivisions = try container.decode([Division].self, forKey: .archivedDivisions)
        divisionIDManager = try container.decode(IDManager.self, forKey: .divisionIDManager)
    }
    
    private enum CodingKeys: CodingKey {
        case currentDivisions, archivedDivisions, divisionIDManager
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(currentDivisions, forKey: .currentDivisions)
        try container.encode(archivedDivisions, forKey: .archivedDivisions)
        try container.encode(divisionIDManager, forKey: .divisionIDManager)
    }
    
    func loadFromFile() {
        // holds save locations on device for app
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // chooses one of the save locations
        let userPath = paths[0]
        // defines path and name of file
        let url = userPath.appendingPathComponent("state.json")
        // fetches data from file
        if let data = try? Data(contentsOf: url) {
            // creates decoder
            let decoder = JSONDecoder()
            // decodes data
            if let loaded = try? decoder.decode(StateController.self, from: data) {
                // assigns data to properties
                currentDivisions = loaded.currentDivisions
                archivedDivisions = loaded.archivedDivisions
            }
        }
    }
    
    func saveToFile() {
        // creates encoder
        let encoder = JSONEncoder()
        // encodes data
        if let encoded = try? encoder.encode(self) {
            // converts to string
            if let json = String(data: encoded, encoding: .utf8) {
                // holds save locations on device for app
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                // chooses one of the save locations
                let userPath = paths[0]
                // defines path and name of file
                let url = userPath.appendingPathComponent("state.json")
                // in case writing fails
                do {
                    // writes JSON to local file
                    try json.write(to: url, atomically: true, encoding: .utf8)
                } catch {
                    //  prints error message if fails
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
    #if DEBUG
    
    static func createNewDivision(name: String, id: Int) -> Division {
        
        let termNames = ["Autumn", "Winter", "Summer"]
        let topics = ["geometry", "calculus", "complex numbers", "mechanics", "architecture", "jelly bean density", "ropes"]
        
        let division = Division(name: name, id: id)
        
        for i in 0...2 {
            division.addTerm()
            
            division.terms[i].name = termNames[i]
            
            for j in 0...5 {
                
                var components = DateComponents()
                components.year = 2021
                components.month = Int.random(in: 1...12)
                components.day = Int.random(in: 1...28)
                let date = Calendar(identifier: .gregorian).date(from: components) ?? Date()
                
                division.addAssignment(assignment: Assignment(name: "A\(j)", date: date, topic: topics[Int.random(in: 0..<topics.count)], id: division.assignmentIDManager.generateNewID()), termIndex: i)
                
                division.terms[i].assignments[j].maximumMark = 100
                division.terms[i].assignments[j].active = true

            }
            
        }
        
        let studentNames = ["Shri Shri Sampta Jhalangar", "Horus of the Eastern Seaboard", "Styrofoam pocketwatch", "Jhabnesh Jhalangar", "Salanatanan Shabteshnarian", "Shrimply Pibbles"]
        
        let excuses = ["Overdue", "Excused"]
        
        for i in 0..<studentNames.count {
            
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
            
            let div = createNewDivision(name: archiveNames[i], id: state.divisionIDManager.generateNewID())
            
            
            state.addToCurrentDivisions(division: div)
            state.archiveDivision(index: 0)
        }
        
        let currentNames = ["VBZ-2", "VCY-3",  "MCZ-1", "PBY-2", "SDN-4"]
        
        for i in 0...4 {
            
            let div = createNewDivision(name: currentNames[i], id: state.divisionIDManager.generateNewID())
            
            state.addToCurrentDivisions(division: div)
        }
        
        return state
        
    }
    
    static let example = createStateController()
    
    #endif
    
}
