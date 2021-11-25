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
    var assignmentIDManager: IDManager
    
    
    init(name: String) {
        self.name = name
        // when creating a new division, provide empty templates then the div can be edited in the Division View
        self.terms = []
        self.students = []
        self.studentIDManager = IDManager()
        self.termIDManager = IDManager()
        self.assignmentIDManager = IDManager()
    }
    
    func addAssignment(name: String, date: Date, topic: String) {
        
        let id = assignmentIDManager.generateNewID()
        
        terms[terms.count - 1].addAssignment(name: name, date: date, topic: topic, id: id )
        
        for student in students {
            student.marks[id] = Mark(value: nil, excuse: "Excused", received: false)
        }
        
    }
    
    func addStudent(name: String, dateOfBirth: Date, contactInfo: String) {
        
        let assignments = self.returnAllAssignments()
        
        let sID = studentIDManager.generateNewID()
        
        let student = Student(name: name, dateOfBirth: dateOfBirth, contactInfo: contactInfo, id: sID, assignments: assignments)
        
        for assignment in assignments {
            assignment.marks[sID] = Mark(value: nil, excuse: "Excused", received: false)
        }
        
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
    
    func returnAllAssignments() -> [Assignment] {
        
        var assignments: [Assignment] = []
        
        for term in terms {
            for assignment in term.assignments {
                assignments.append(assignment)
            }
        }
        
        return assignments
    }
    
    #if DEBUG
    static func createDivision(name: String) -> Division {
        let division = Division(name: name)
        
        for _ in 0...3 {
            division.addTerm()
            
            for j in 0...3 {
                division.addAssignment(name: "A\(j)", date: Date(), topic: "good topic")
            }
            
        }
        
        for i in 0...4 {
            division.addStudent(name: "S\(i)", dateOfBirth: Date(), contactInfo: "gmail.email@bmail.org.ind")
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
