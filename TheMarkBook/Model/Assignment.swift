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
    var topic: String
    var marks: [Int:Mark]
    var maximumMark: Double
    
    init(name: String, date: Date, topic: String, id: Int) {
        
        self.name = name
        self.date = date
        self.id = id
        self.topic = topic
        self.marks = [:]
        self.maximumMark = 1
        
    }
    
    func updateMarks(marks: [Int:Mark]) {
        self.marks = marks
        
        var total: Double = 0
        
        for (_, mark) in marks {
            if let x = mark.value {
                total += Double(x)
            }
        }
                
    }
    
    func returnAverageAbsoluteMark() -> Double {
        
        // checks if there are any marks
        if self.numberReceived() <= 0 {
            return 0
        }
        
        // checks whether total mark is below 0
        if self.totalMark() <= 0 {
            return 0
        }
        
        // returns average mark value
        return self.totalMark() / Double(self.numberReceived())
        
    }
    
    func returnAveragePercentageMark() -> Double {
        
        // checks if there are any marks
        if self.numberReceived() <= 0 {
            return 0
        }
        
        // checks whether total mark is below 0
        if self.totalMark() <= 0 {
            return 0
        }
        
        // returns average mark value
        return self.totalMark() / ( Double(self.numberReceived()) * self.maximumMark )
        
    }
    
    func numberReceived() -> Int {
        
        // defines variable that will hold no. received
        var count = 0
        
        // accesses each mark in marks dictionary
        for (_, mark) in self.marks {
            // checks that assignment is handed in
            if mark.received {
                // keeps count of no. received
                count += 1
            }
        }
        
        // returns value
        return count
        
    }
    
    func totalMark() -> Double {
        
        // defines variable that will hold total mark
        var total: Double = 0
        
        // accesses each mark in the assignment
        for (_, mark) in self.marks {
            // makes sure value is not nil
            if mark.received {
                // adds value to total
                total += mark.returnUnwrappedValue()
            }
        }
        
        // returns value
        return total
    
    }
    
    
}
