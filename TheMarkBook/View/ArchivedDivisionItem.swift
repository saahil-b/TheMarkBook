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
        
    @State var menuVisible = false
    
    var body: some View {
        
        HStack {
            Image(systemName: "\(division.students.count).circle")

            Text("\(division.name)")
            
            Spacer()
            
                Button(action: { menuVisible = true }, label: {
                    Image(systemName: "ellipsis")
                })
                .actionSheet(isPresented: $menuVisible) {
                    ActionSheet(title: Text("What action would you like to perform?"),
                                message: Text(division.name),
                                buttons: [
                                    .default(Text("Recover")) {
                                        recoverDivision(index)
                                    },
                                    .destructive(Text("Delete")) {
                                        deleteDivision(index)
                                    },
                                    .cancel()
                                ]
                    )
                }
            
        }
        
    }
}

struct ArchivedDivisionItem_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedDivisionItem(division: Division.archiveExamples[0], index: 0, recoverDivision: {_ in}, deleteDivision: {_ in})
    }
}
