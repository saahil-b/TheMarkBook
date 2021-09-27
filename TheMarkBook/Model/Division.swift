//
//  Division.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import Foundation

class Division {
    var name : String
    //var terms: [Term]
    //var students: [Student]
    
    
    init(name: String) {
        self.name = name
        // when creating a new division, provide empty templates then the div can be edited in the Division View
    }
    
    #if DEBUG
    static func createDivision(name: String) -> Division {
        let division = Division(name: name)
        return division
    }
    
    static let currentExamples = [Division.createDivision(name: "VCX-1"),
                           Division.createDivision(name: "VBY-1"),
                           Division.createDivision(name: "MCW-2")]
    
    static let archiveExamples = [Division.createDivision(name: "A1"),
                                  Division.createDivision(name: "A2"),
                                  Division.createDivision(name: "A3")]
    #endif
}
