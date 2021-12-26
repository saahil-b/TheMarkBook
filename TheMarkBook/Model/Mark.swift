//
//  Mark.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import Foundation

class Mark: Codable {
    
    var value: Double?
    var excuse: String?
    
    var received: Bool
    
    init(value: Double?, excuse: String?, received: Bool) {
        self.value = value
        self.excuse = excuse
        self.received = received
    }
    
    func haveReceived() {
        self.value = 0
    }
    
    func haveNotReceived() {
        self.value = nil
        self.excuse = "Overdue"
    }
    
    func returnUnwrappedValue() -> Double {
        if let unwrappedValue = self.value {
            return unwrappedValue
        }
        
        return 0
    }
    
    func returnUnwrappedExcuse() -> String {
        if let unwrappedExcuse = self.excuse {
            return unwrappedExcuse
        }
        
        return "Problem unwrapping in class"
    }
    
    static func returnDefaultValue() -> Mark {
        Mark(value: nil, excuse: "Excused", received: false)
    }
    
    #if DEBUG
    
    static let example = Mark(value: 90.0, excuse: nil, received: false)
    
    #endif
    
}

