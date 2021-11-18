//
//  Division.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import Foundation

class Division {
    var name : String
    var terms: [Term]
    var students: [Student]
    var studentIDManager: IDManager
    var termIDManager: IDManager
    
    
    init(name: String) {
        self.name = name
        // when creating a new division, provide empty templates then the div can be edited in the Division View
        self.terms = []
        self.students = []
        self.studentIDManager = IDManager()
        self.termIDManager = IDManager()
    }
    
    func addStudent(name: String, dateOfBirth: Date, contactInfo: String) {
        
        var assignments: [Assignment] = []
        
        for term in terms {
            for assignment in term.assignments {
                assignments.append(assignment)
            }
        }
        
        let student = Student(name: name, dateOfBirth: dateOfBirth, contactInfo: contactInfo, id: studentIDManager.generateNewID(), assignments: assignments)
        
        self.students.append(student)
    }
    
    func removeStudent(index: Int) {
        self.students.remove(at: index)
    }
    
    func moveStudent(fromOffsets: IndexSet, toOffset: Int) {
        self.students.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addTerm() {
        let term = Term(name: "New Term", id: termIDManager.generateNewID())
        
        self.terms.append(term)
        
    }
    
    #if DEBUG
    static func createDivision(name: String) -> Division {
        let division = Division(name: name)
        
        for i in 0...3 {
            division.addTerm()
            
            for j in 0...3 {
                division.terms[i].addAssignment(name: "A\(j)", date: Date(), topic: "M")
            }
            
        }
        
        for i in 0...4 {
            division.addStudent(name: "S\(i)", dateOfBirth: Date(), contactInfo: "gmail.email@jmail")
        }
        
        return division
    }
    
    static let currentExamples = [Division.createDivision(name: "VCX-1"),
                           Division.createDivision(name: "VBY-1"),
                           Division.createDivision(name: "MCW-2")]
    
    static let archiveExamples = [Division.createDivision(name: "A1"),
                                  Division.createDivision(name: "A2"),
                                  Division.createDivision(name: "A3")]
    #endif
}
