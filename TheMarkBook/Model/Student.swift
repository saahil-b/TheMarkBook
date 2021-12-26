//
//  Student.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import Foundation

class Student: Codable {
    
    var name: String
    var dateOfBirth: Date
    var contactInfo: String
    var id: Int
    var marks: [Int:Mark]
    
    init(name: String, dateOfBirth: Date, contactInfo: String, id: Int, assignments: [Assignment]) {
        
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.contactInfo = contactInfo
        self.id = id
        
        self.marks = [:]
        
        for assignment in assignments {
            self.marks[assignment.id] = Mark(value: nil, excuse: "Excused", received: false)
        }
        
    }
    

    #if DEBUG
    static func createStudent() -> Student {
        return Student(name: "Johnny", dateOfBirth: Date(), contactInfo: "gmail", id: 99, assignments: [])
    }

    static let example = Student.createStudent()

    #endif

}
