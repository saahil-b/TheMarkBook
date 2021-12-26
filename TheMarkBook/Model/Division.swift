//
//  Division.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import Foundation

class Division: Codable {
    var name : String
    var id: Int
    var terms: [Term]
    var students: [Student]
    var studentIDManager: IDManager
    var termIDManager: IDManager
    var assignmentIDManager: IDManager
        
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.terms = []
        self.students = []
        self.studentIDManager = IDManager()
        self.termIDManager = IDManager()
        self.assignmentIDManager = IDManager()
    }
    
    func addAssignment(assignment: Assignment, termIndex: Int) {
        
        var marks: [Int:Mark] = [:]
        
        for student in self.students {
            marks[student.id] = Mark.returnDefaultValue()
            student.marks[assignment.id] = Mark.returnDefaultValue()
        }
        
        assignment.updateMarks(marks: marks)
        
        terms[termIndex].addAssignment(name: assignment.name, date: assignment.date, topic: assignment.topic, id: assignment.id )
        
    }
    
    func addStudent(name: String, dateOfBirth: Date, contactInfo: String) {
        
        let assignments = self.returnAllAssignments()
        
        let sID = studentIDManager.generateNewID()
        
        let student = Student(name: name, dateOfBirth: dateOfBirth, contactInfo: contactInfo, id: sID, assignments: assignments)
        
        for assignment in assignments {
            var marks = assignment.marks
            
            marks[sID] = Mark.returnDefaultValue()
                
            assignment.updateMarks(marks: marks)
        }
        
        self.students.append(student)
    }
    
    func removeStudent(index: Int) {
        
        let assignments = self.returnAllAssignments()
        
        for assignment in assignments {
            assignment.marks.removeValue(forKey: self.students[index].id)
        }
        
        self.students.remove(at: index)
        
    }
    
    func moveStudent(fromOffsets: IndexSet, toOffset: Int) {
        self.students.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addTerm() {
        let term = Term(name: "New term", id: termIDManager.generateNewID())
        
        self.terms.append(term)
        
    }
    
    func removeTerm(index: Int) {
        self.terms.remove(at: index)
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
    
    func updateAssignmentsWithStudentMarkChanges(marks: [Int:Mark], studentID: Int) {
        
        for term in terms {
            for assignment in term.assignments {
                assignment.marks[studentID] = marks[assignment.id]
            }
        }
        
    }
    
    func updateStudentWithAssignmentMarkChanges(marks: [Int: Mark], assignmentID: Int) {
        
        for student in students {
            student.marks[assignmentID] = marks[student.id]
        }
        
    }
        
    func returnDefaultMarks() -> [Int:Mark] {
        var marks: [Int:Mark] = [:]
        
        for student in students {
            marks[student.id] = Mark.returnDefaultValue()
        }
        
        return marks
        
    }
    
    
    
    #if DEBUG
    static func createDivision(name: String, id: Int) -> Division {
        let division = Division(name: name, id: id)
        
        for i in 0...3 {
            division.addTerm()
            
            for j in 0...3 {
                division.addAssignment(assignment: Assignment(name: "A\(j)", date: Date(), topic: "good topic", id: division.assignmentIDManager.generateNewID()), termIndex: i)
            }
            
        }
        
        for i in 0...4 {
            division.addStudent(name: "S\(i)", dateOfBirth: Date(), contactInfo: "gmail.email@bmail.org.ind")
        }
        
        return division
    }
    
    static let currentExamples = [Division.createDivision(name: "VCX-1", id: 1),
                                  Division.createDivision(name: "VBY-1", id: 2),
                           Division.createDivision(name: "MCW-2", id: 3)]
    
    static let archiveExamples = [Division.createDivision(name: "A1", id: 4),
                                  Division.createDivision(name: "A2", id: 5),
                                  Division.createDivision(name: "A3", id: 6)]
    #endif
}
