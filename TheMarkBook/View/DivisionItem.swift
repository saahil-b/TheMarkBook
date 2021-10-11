//
//  DivisionItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionItem: View {
    
    @EnvironmentObject var state: StateController
    @State var index: Int
    
    var body: some View {
                
        HStack {
            Image(systemName: "\(state.currentDivisions[index].students.count).circle")
            //division.students.count
            Text("\(state.currentDivisions[index].name)")
            Spacer()
                        
        }
    }
}

struct DivisionItem_Previews: PreviewProvider {
    static var previews: some View {
        DivisionItem(index: 0)
            .environmentObject(StateController.example)
    }
}
