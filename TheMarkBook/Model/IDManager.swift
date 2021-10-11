//
//  IDManager.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 08/10/2021.
//

import Foundation

class IDManager {
    
    var maxID: Int
    
    init() {
        self.maxID = 0
    }
    
    func generateNewID() -> Int {
        self.maxID += 1
        return maxID
        
    }
    
}

