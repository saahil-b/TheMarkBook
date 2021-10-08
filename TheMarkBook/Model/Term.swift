//
//  Term.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 08/10/2021.
//

import Foundation

class Term {
    var name: String
    var assignments: [Assignment]
    var assignmentIDManager: IDManager
    
    init(name: String) {
        self.name = name
        self.assignments = []
        self.assignmentIDManager = IDManager()
    }
    
    func addAssignment(name: String, date: Date, topic: String) {
        let assignment = Assignment(name: name, date: date, topic: topic, id: assignmentIDManager.generateNewID())
        self.assignments.append(assignment)
    }
    
    func removeAssignment(index: Int) {
        self.assignments.remove(at: index)
    }
    
}


