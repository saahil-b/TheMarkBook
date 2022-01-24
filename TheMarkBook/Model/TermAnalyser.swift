//
//  TermAnalyser.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 15/12/2021.
//

import Foundation


class TermAnalyser {
    
    let term: Term
    let division: Division
    
    init(term: Term, division: Division) {
        self.term = term
        self.division = division
    }
    
    func returnOrderedAssignments() -> [Assignment] {
        // initialises lists
        let assignments: [Assignment] = term.assignments
        var dates: [Date] = []
        
        // accesses each assignment for the division
        for assignment in assignments {
            dates.append(assignment.date)
        }
        
        // sorts assignments by date using bubble sort
        return Algorithms.bubbleSortAssignmentsByDate(dates: dates, items: assignments)
        
    }
    
    func averagePercentageOverTime() -> [Double] {
        
        let assignments = self.returnOrderedAssignments()
        
        // holds average mark for all assignments
        var averages: [Double] = []
        // accesses each assignment
        for assignment in assignments {
            // appends avg mark for assignment to averages
            averages.append(assignment.returnAveragePercentageMark())
        }
        
        // returns average marks in order of earliest due date
        return averages
        
    }
    
    func handedInValues() -> [Int] {
        
        // variables for keeping count
        var handedIn = 0
        var notIn = 0
        
        // accesses every assignment
        for assignment in term.assignments {
            // accesses each mark for an assignment
            for (_, mark) in assignment.marks {
                // checks if assignment is handed in
                if mark.received {
                    handedIn += 1
                } else {
                    notIn += 1
                }
            }
        }
        
        // returns values
        return [handedIn, notIn]
        
    }
    
    func rankStudents() -> [String] {
        
        var totals: [Int:Double] = [:]
        var count: [Int:Int] = [:]
        
        // accesses each stduent in the division
        for student in division.students {
            totals[student.id] = 0
            count[student.id] = 0
        }
        
        // accesses every assignment in a term
        for assignment in term.assignments {
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
        
        // final array of student names in order
        var ranking: [String] = []
        // accesses every score in order
        for score in scores {
            // holds name(s) of student(s) with that score
            var current = ""
            // accesses every student
            for student in division.students {
                // checks if student score is the same as current score
                if totals[student.id] == score {
                    if current == "" {
                        current = student.name
                    } else {
                        current += "/ \(student.name)"
                    }
                }
            }
            // adds names(s) to ranking
            ranking.append(current)
        }
        
        return ranking
        
    }
    
    func bestPerformingTopics() -> [String] {
        
        var totals: [String:Double] = [:]
        var count: [String: Int] = [:]
        // accesses every assignment in term
        for assignment in term.assignments {
            // checks if topic is already a key in dictionary
            if totals.keys.contains(assignment.topic) {
                // adds average percentage mark to total for topic
                totals[assignment.topic]! += assignment.returnAveragePercentageMark()
                // keeps count of no. scores for topic
                count[assignment.topic]! += 1
                
            } else {
                // adds topic to totals dicitonary
                totals[assignment.topic] = assignment.returnAveragePercentageMark()
                // adds topic to count dictionary
                count[assignment.topic] = 1
            }
        }
        
        var scores: [Double] = []
        var ranking: [String] = []
        
        for score in totals.values.sorted() {
            // ensures no duplicate scores
            if !scores.contains(score) {
                // keeps track of score
                scores.append(score)
                
                var current = ""
                // accesses each topic
                for topic in totals.keys {
                    // checks if topic score is same as current
                    if totals[topic]! == score {
                        if current == "" {
                            current = topic
                        } else {
                            current += topic
                        }
                        // removes topic from totals for efficiency
                        totals.removeValue(forKey: topic)
                    }
                }
                // adds current (list of) topics to ranking
                ranking.append(current)
            }
        }
        // returns topics in ranked order
        return ranking
        
    }
    
}
