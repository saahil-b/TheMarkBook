//
//  Mark.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import Foundation

class Mark {
    var value: Int?
    var excuse: String?
    
    var received: Bool {
        didSet {
            if received == true {
                haveReceived()
            } else {
                haveNotReceived()
            }
        }
    }
    
    init(value: Int?, excuse: String?, received: Bool) {
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
    
}

