//
//  Algorithms.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 14/12/2021.
//

import Foundation

struct Algorithms {
    
    static func bubbleSortAssignmentsByDate(dates: [Date], items: [Assignment]) -> [Assignment] {
        
        // checks if there are any items in each array
        if items.count == 0 || dates.count == 0 || items.count != dates.count{
            return []
        }
        
        // copies input data
        var sortedDates = dates
        var sortedItems = items
        
        // variable that holds whether sorting is done
        var done = false
        // checks if sorting is finished
        while !done {
            done = true
            // loops through whole array
            for i in 0..<(items.count - 1) {
                // checks if currend date is bigger than next
                if sortedDates[i] > sortedDates[i+1] {
                    // sort is not finished
                    done = false
                    // carries out swap on test data
                    sortedDates.swapAt(i, i+1)
                    // carries out swap on assignment data
                    sortedItems.swapAt(i, i+1)
                }
            }
            
        }
        
        // returns items once sorted
        return sortedItems
        
    }
    
    
}
