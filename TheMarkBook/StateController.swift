//
//  StateController.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import Foundation

class StateController {
    var currentDivisions : [Division]
    var archivedDivisions : [Division]
    
    init(current: [Division], archive: [Division]) {
        self.currentDivisions = current
        self.archivedDivisions = archive
    }
    
    func addNewDivision(division : Division){
        currentDivisions.append(division)
    }
    
    func deleteFromCurrentDivisions(index: Int){
        currentDivisions.remove(at: index)
    }
    
    func archiveDivision(index: Int){
        let division = currentDivisions[index]
        // find division in currentDivisions
        // remove from currentDivisions
        archivedDivisions.append(division)
    }
    
    func recoverDivision(index: Int){
        let division = currentDivisions[index]
        // find division in archivedDivisions
        // remove from archivedDivisions
        currentDivisions.append(division)
    }
    
    func deleteFromArchivedDivisions(index: Int){
        archivedDivisions.remove(at: index)
    }
    
}
