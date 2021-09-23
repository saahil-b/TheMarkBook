//
//  DivisionItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionItem: View {
    
    let division: Division
    @Binding var editing: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "\(3).circle")
            //division.students.count
            Text("\(division.name)")
            Spacer()
            
            // make the editing published now so the buttons actually go
            if editing {
                Button(action: {}) {
                    Image(systemName: "archivebox.circle")
                }
                Button(action: {}) {
                    Image(systemName: "minus.circle")
                }
            }
        }
    }
}

struct DivisionItem_Previews: PreviewProvider {
    static var previews: some View {
        @State static var editing: Bool = false
        DivisionItem(division: Division.currentExamples[0], editing: $editing )
    }
}
