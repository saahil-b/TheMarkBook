//
//  Assignment.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import Foundation

class Assignment {
    
    var name: String
    var date: Date
    var id: Int
    var topic: String?
    var marks: [Int:Mark]
    var totalMark: Double
    
    init(name: String, date: Date, topic: String, id: Int) {
        
        self.name = name
        self.date = date
        self.id = id
        self.topic = topic
        self.marks = [:]
        self.totalMark = 0
        
    }
    
    func updateInfo(name: String, date: Date, topic: String) {
        self.name = name
        self.date = date
        self.topic = topic
    }
    
    func updateMarks(marks: [Int:Mark]) {
        self.marks = marks
        
        var total: Double = 0
        
        for (_, mark) in marks {
            if let x = mark.value {
                total += Double(x)
            }
        }
        
        self.totalMark = total
        
    }
    
    
}
