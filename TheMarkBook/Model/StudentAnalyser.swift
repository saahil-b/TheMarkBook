//
//  StudentAnalyser.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 13/12/2021.
//

import Foundation

class StudentAnalyser {
    
    var student: Student
    var division: Division
    
    init(student: Student, division: Division) {
        self.student = student
        self.division = division
    }
    
    func returnOrderedAssignments() -> [Assignment] {
        // initialises lists
        var assignments: [Assignment] = division.returnAllAssignments()
        var dates: [Date] = []
        
        // accesses each assignment for the division
        for assignment in assignments {
            dates.append(assignment.date)
        }
        
        // sorts assignments by date using bubble sort
        assignments = Algorithms.bubbleSortAssignmentsByDate(dates: dates, items: assignments)
        
        var final: [Assignment] = []
                
        // checks if mark values are valid
        for assignment in assignments {
            if let x = assignment.marks[student.id] {
                if x.received {
                    if let _ = x.value {
                        final.append(assignment)
                    }
                }
            }
        }
                
        return final
        
    }
    
    
    func percentageMarkOverTime() -> [Double] {
        
        // sorts assignments by date using bubble sort
        let assignments = self.returnOrderedAssignments()
        var percentages: [Double] = []
        
        // accesses all assignments in the division
        for assignment in assignments {
            // unwraps the student's mark for the assignment
            if let x = assignment.marks[student.id] {
                // checks if work has been handed in
                if x.received {
                    // appends average mark to array
                    percentages.append(x.returnUnwrappedValue()/assignment.maximumMark)
                }
            }
        }
        
        // returns values
        return percentages
        
    }
    
    func percentageMarkComparedToAverage() -> [Double] {
        
        // defines array that holds differences
        var differences: [Double] = []
        
        var studentMark: Double
        var avgMark: Double
        
        // accesses all assignments in a division
        for assignment in self.returnOrderedAssignments() {
            // unwraps student mark for assignment
            if let x = assignment.marks[student.id] {
                // checks if work is handed in
                if x.received {
                    // checks if max mark is bigger than 0
                    if assignment.maximumMark > 0 {
                        // calculates student's percentage mark
                        studentMark = x.returnUnwrappedValue()/assignment.maximumMark
                        // calculates average percentage mark for class
                        avgMark = assignment.returnAveragePercentageMark()
                        // appends difference to array
                        differences.append(studentMark - avgMark)
                    }
                }
            }
        }
        
        // returns differences
        return differences
        
    }
    
//    func favouriteTopic() -> String {
//
//        // defines array that holds differences
//        var favouriteTopic: String = "N/A"
//        var bestDifference: Double = -Double.greatestFiniteMagnitude
//
//        var studentMark: Double
//        var avgMark: Double
//
//        // accesses all assignments in a division
//        for assignment in division.returnAllAssignments() {
//            // unwraps student mark for assignment
//            if let x = assignment.marks[student.id] {
//                // checks if work is handed in
//                if x.received {
//                    // checks if max mark is bigger than 0
//                    if assignment.maximumMark > 0 {
//                        // calculates student's percentage mark
//                        studentMark = x.returnUnwrappedValue()/assignment.maximumMark
//                        // calculates average percentage mark for class
//                        avgMark = assignment.returnAveragePercentageMark()
//                        // checks if difference is better
//                        if (studentMark - avgMark) > bestDifference {
//                            // stores favourite topic
//                            favouriteTopic = assignment.topic
//                            // records new best difference
//                            bestDifference = studentMark - avgMark
//                        }
//                    }
//                }
//            }
//        }
//
//        // returns favourite topic
//        return favouriteTopic
//
//    }
    
    func favouriteTopic() -> String {
        
        var totals: [String:Double] = [:]
        var count: [String: Int] = [:]
        // accesses every assignment in division
        for assignment in division.returnAllAssignments() {
            // checks if topic is already a key in dictionary
            if totals.keys.contains(assignment.topic) {
                // unwraps mark
                if let mark = student.marks[assignment.id] {
                    // unwraps value
                    if let value = mark.value {
                        // calculates student % mark
                        let studentPerc = value / assignment.maximumMark
                        // calculates mean % mark
                        let meanPerc = assignment.returnAveragePercentageMark()
                        // calulates difference and adds to topic total
                        totals[assignment.topic]! = studentPerc - meanPerc
                        // keeps count of no. scores for topic
                        count[assignment.topic]! += 1
                    }
                }
                
            } else {
                // unwraps mark
                if let mark = student.marks[assignment.id] {
                    // unwraps value
                    if let value = mark.value {
                        // calculates student % mark
                        let studentPerc = value / assignment.maximumMark
                        // calculates mean % mark
                        let meanPerc = assignment.returnAveragePercentageMark()
                        // calulates difference and assigns to topic
                        totals[assignment.topic] = studentPerc - meanPerc
                        // keeps count of no. scores for topic
                        count[assignment.topic] = 1
                    }
                }
            }
        }
        
        var favouriteTopic: String = "N/A"
        var bestAverage = -Double.greatestFiniteMagnitude
        // accesses every total
        for (topic, total) in totals {
            // calculates score for topic
            let score = total / Double(count[topic]!)
            // checks if score is higher than current highest
            if score > bestAverage {
                // sets current topic to favourite topic
                bestAverage = score
                favouriteTopic = topic
            } else if score == bestAverage {
                // adds to joint favourite topics
                favouriteTopic += "/ \(topic)"
            }
        }
                
        // returns favourite topic
        return favouriteTopic
        
    }
    
    func studentPosition() -> String {
        
        var totals: [Int:Double] = [:]
        var count: [Int:Int] = [:]
        
        // accesses each stduent in the division
        for student in division.students {
            totals[student.id] = 0
            count[student.id] = 0
        }
        
        // accesses every assignment in a division
        for assignment in division.returnAllAssignments() {
            // accesses all marks for each assignment
            for (sID, mark) in assignment.marks {
                // checks if assignment was handed in
                if mark.received {
                    totals[sID]! += mark.returnUnwrappedValue()/assignment.maximumMark
                    count[sID]! += 1
                }
            }
        }
        
        // replaces total score with average score
        for (id, total) in totals {
            // if no marks handed in assign lowest possible value
            if count[id]! == 0 {
                totals[id] = -Double.greatestFiniteMagnitude
            } else {
                totals[id] = total/Double(count[id]!)
            }
        }
        
        // array for all scores
        var scores: [Double] = []
        // acesses every score from lowest to highest
        for item in totals.values.sorted(by: >) {
            // adds score to scores in order and ensuring no duplicates
            if !scores.contains(item) {
                scores.append(item)
            }
        }
        
        var position = division.students.count
        
        // finds student score position
        if let x = scores.firstIndex(of: totals[student.id]!) {
            position = x
        }
        
        // returns ordinal of position
        if position == 0 {
            return "1st"
        }
        if position == 1 {
            return "2nd"
        }
        if position == 2 {
            return "3rd"
        }
        return "\(position + 1)th"
        
    }
    
    func handedInValues() -> [Int] {
        
        // variables for keeping count
        var handedIn = 0
        var notIn = 0
        
        // accesses each student mark
        for (_, mark) in self.student.marks {
            // checks if handed in
            if mark.received {
                // adds to handed in count
                handedIn += 1
            } else {
                // adds to not handed in count
                notIn += 1
            }
        }
        
        // returns values
        return [handedIn, notIn]
        
    }
            
}
