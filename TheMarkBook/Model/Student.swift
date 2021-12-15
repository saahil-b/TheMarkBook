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
        
//    func totalMark() -> Double {
//
//        var total: Double = 0
//
//        for (_, mark) in self.marks {
//            if mark.received {
//                total += mark.returnUnwrappedValue()
//            }
//        }
//
//        return total
//
//    }
//
//    func numberHandedIn() -> Int {
//
//        var count: Int = 0
//
//        for (_, mark) in self.marks {
//            if mark.received {
//                count += 1
//            }
//        }
//
//        return count
//
//    }
//

    
    

    #if DEBUG
    static func createStudent() -> Student {
        return Student(name: "Johnny", dateOfBirth: Date(), contactInfo: "gmail", id: 99, assignments: [])
    }

    static let example = Student.createStudent()

    #endif

}
