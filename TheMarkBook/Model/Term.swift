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
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.assignments = []
        self.id = id
    }
    
    func addAssignment(name: String, date: Date, topic: String, id: Int) {
        let assignment = Assignment(name: name, date: date, topic: topic, id: id)
        self.assignments.append(assignment)
    }
    
    func moveAssignment(fromOffsets: IndexSet, toOffset: Int) {
        self.assignments.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func removeAssignment(index: Int) {
        self.assignments.remove(at: index)
    }
    
}


