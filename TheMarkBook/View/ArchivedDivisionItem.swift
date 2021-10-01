//
//  ArchivedDivisionItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 01/10/2021.
//

import SwiftUI

struct ArchivedDivisionItem: View {
    
    @EnvironmentObject var state: StateController
    
    let division: Division
    
    var body: some View {
        
        HStack {
            Image(systemName: "\(7).circle")
            //division.students.count
            Text("\(division.name)")
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Recover")
            })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Delete")
            })
                        
        }
    }
}

struct ArchivedDivisionItem_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedDivisionItem(division: Division.archiveExamples[0])
            .environmentObject(StateController.example)
    }
}
