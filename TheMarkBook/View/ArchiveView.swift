//
//  ArchiveView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 17/09/2021.
//

import SwiftUI

struct ArchiveView: View {
    
    @EnvironmentObject var state: StateController
    
    @State var menuVisible = false
    
    var body: some View {
        
        VStack {
            
            // archive title
            Text("Bin")
                .font(.largeTitle)
            
            // list of archived divisions
            List {
                ForEach(Array(state.archivedDivisions.enumerated()), id: \.self.offset) { i, division in
                        
                    ArchivedDivisionItem(division: division, index: i, recoverDivision: recoverDivision, deleteDivision: deleteDivision, menuRequest: menuRequest)
                        
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
    
    func menuRequest(index: Int) {
        //
    }
    
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
            .environmentObject(StateController.example)
    }
}
