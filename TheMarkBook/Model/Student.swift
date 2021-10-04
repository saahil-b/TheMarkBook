//
//  Student.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import Foundation

class Student {
    
    var name: String
    var dateOfBirth: Date
    var contactInfo: String
    var marks: [Assignment:Mark]
    
    init(name: String, dateOfBirth: Date, contactInfo: String, assignments: [Assignment]) {
        
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.contactInfo = contactInfo
        
        for assignment in assignments {
            self.marks[assignment] = Mark(value: nil, excuse: String)
        }
        
        
    }
    
}
