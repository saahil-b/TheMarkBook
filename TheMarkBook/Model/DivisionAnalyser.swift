//
//  DivisionAnalyser.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 14/12/2021.
//

import Foundation


class DivisionAnalyser {
    
    let division: Division
    
    init(division: Division) {
        self.division = division
    }
    
    func returnOrderedAssignments() -> [Assignment] {
        // initialises lists
        let assignments: [Assignment] = division.returnAllAssignments()
        var dates: [Date] = []
        
        // accesses each assignment for the division
        for assignment in assignments {
            dates.append(assignment.date)
        }
        
        // sorts assignments by date using bubble sort
        return Algorithms.bubbleSortAssignmentsByDate(dates: dates, items: assignments)
        
    }
    
    func averagePercentageOverTime() -> [Double] {
                
        // sorts assignments by date
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
    
    func bestPerformingTopic() -> String {
        
        var totals: [String:Double] = [:]
        var count: [String: Int] = [:]
        // accesses every assignment in division
        for assignment in division.returnAllAssignments() {
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
    
    func handedInValues() -> [Int] {
        
        // variables for keeping count
        var handedIn = 0
        var notIn = 0
        
        // accesses every assignment
        for assignment in division.returnAllAssignments() {
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
        
        // accesses each student in the division
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
    
    func bestPerformingTerms() -> [String] {
        
        // relates IDs to scores
        var termScores: [Int:Double] = [:]
        // rank of IDs
        var ranking: [Int] = []
        // relates IDs to names
        var idName: [Int:String] = [:]
        
        // accesses every term in a division
        for term in division.terms {
            // adds term to dict
            idName[term.id] = term.name
            // tracks score for term
            var score: Double = 0
            // accesses every assignment in the term
            for assignment in term.assignments {
                score += assignment.returnAveragePercentageMark()
            }
            // final term score
            let final = score/Double(term.assignments.count)
            // adds term score to score dictionary
            termScores[term.id] = final
            
            var added = false
            var i = 0
            // checks if ID added to ranking
            while !added {
                // handles case where ranking is empty
                if ranking == [] {
                    ranking.append(term.id)
                    added = true
                }
                // handles case where score is smallest
                if i >= ranking.count {
                    ranking.append(term.id)
                    added = true
                }
                // checks if score is bigger
                if final > termScores[ranking[i]]! {
                    // inserts ID into ranking
                    ranking.insert(term.id, at: i)
                    added = true
                }
                // increments index
                i += 1
            }
        }
        var result: [String] = []
        // accesses every ID in order
        for rank in ranking {
            // adds name of term to result
            result.append(idName[rank]!)
        }
        return result
        
    }
    
    func bestPerformingTopics() -> [String] {
        
        var totals: [String:Double] = [:]
        var count: [String: Int] = [:]
        // accesses every assignment in division
        for assignment in division.returnAllAssignments() {
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
