//
//  ArchivedDivisionItem.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 13/12/2021.
//

import SwiftUI

struct ArchivedDivisionItem: View {
    
    let division: Division
    let index: Int
    
    let recoverDivision: (Int) -> Void
    let deleteDivision: (Int) -> Void
    
    let menuRequest: (Int) -> Void
    
    @State var menuVisible = false
    
    var body: some View {
        
        HStack {
            Image(systemName: "\(division.students.count).circle")

            Text("\(division.name)")
            
            
            Spacer()
            
            Button(action: { menuVisible = true }, label: {
                Image(systemName: "ellipsis")
            })
//            .confirmationDialog("Which fruit would you like to eat?", isPresented: $menuVisible, titleVisibility: .visible) {
//                Button("Recover") {
//                    recoverDivision(index)
//                }
//
//                Button("Delete", role: .destructive) {
//                    deleteDivision(index)
//                }
//            }
                        
        }
                
        
    }
}

struct ArchivedDivisionItem_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedDivisionItem(division: Division.archiveExamples[0], index: 0, recoverDivision: {_ in}, deleteDivision: {_ in}, menuRequest: {_ in})
    }
}
