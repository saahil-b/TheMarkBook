//
//  ChartDataConverter.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 13/12/2021.
//

import Charts
import Foundation

struct ChartDataConverter {
    
    static func SingleValueBarDataEntries(values: [Double]) -> [BarChartDataEntry] {
        
        // array that holds all entries
        var entries: [BarChartDataEntry] = []
        
        // accesses index of each value in values
        for i in 0..<values.count {
            // adds new entry with y-value of value
            entries.append(BarChartDataEntry(x: Double(i), y: values[i]))
        }
        
        // reutrns the entries
        return entries
    }
    
}
