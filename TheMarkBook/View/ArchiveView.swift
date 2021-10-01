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
            
            // archive title
            Text("Archive")
                .font(.largeTitle)
            
            // lsit of archived divisions
            List {
                ForEach(state.archivedDivisions, id: \.self.name) { division in
                        
                        ArchivedDivisionItem(division: division)
                        
                }
            }
        }
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
            .environmentObject(StateController.example)
    }
}
