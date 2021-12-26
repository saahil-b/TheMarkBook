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
    
    
    func percentageMarkOverTime() -> [Double] {
        
        // defines array in which values will be held
        var percentages: [Double] = []
        
        // array of all assignments in division
        var assignments = division.returnAllAssignments()
        
        // holds dates of all assignments
        var dates: [Date] = []
        
        // accesses each assignment for the division
        for assignment in assignments {
            dates.append(assignment.date)
        }
        
        // sorts assignments by date using bubble sort
        assignments = Algorithms.bubbleSortAssignmentsByDate(dates: dates, items: assignments)
        
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
        for assignment in division.returnAllAssignments() {
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
    
    func favouriteTopic() -> String {
        
        // defines array that holds differences
        var favouriteTopic: String = "N/A"
        var bestDifference: Double = -Double.greatestFiniteMagnitude
        
        var studentMark: Double
        var avgMark: Double
        
        // accesses all assignments in a division
        for assignment in division.returnAllAssignments() {
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
                        // checks if difference is better
                        if (studentMark - avgMark) > bestDifference {
                            // stores favourite topic
                            favouriteTopic = assignment.topic
                            // records new best difference
                            bestDifference = studentMark - avgMark
                        }
                    }
                }
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
