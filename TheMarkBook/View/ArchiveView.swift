//
//  ArchiveView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 17/09/2021.
//

import SwiftUI

struct ArchiveView: View {
    
    @EnvironmentObject var state: StateController
    
    var body: some View {
        
        VStack {
            
            if state.archivedDivisions.count > 0 {
                // archive title
                Text("Bin")
                    .font(.largeTitle)
            } else {
                // text displayed when bin is empty
                Text("Bin is empty")
                    .font(.title)
            }
            
            // list of archived divisions
            List {
                ForEach(Array(state.archivedDivisions.enumerated()), id: \.self.offset) { i, division in
                    ArchivedDivisionItem(division: division, index: i, recoverDivision: recoverDivision, deleteDivision: deleteDivision)
                }
            }

        }
        
    }
    
    func recoverDivision(index: Int) {
        state.recoverDivision(index: index)
    }
    
    func deleteDivision(index: Int) {
        state.deleteFromArchivedDivisions(index: index)
    }
    
    
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
            .environmentObject(StateController.example)
    }
}
