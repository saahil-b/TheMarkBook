//
//  StudentMarkItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentMarkItem: View {
    
    @State var changingMarks: [Int:Mark]
    @State var terms: [Term]
    
    var body: some View {
        
        VStack {
            
            Text("Marks")
                .font(.title)
                            
            List {
                // accesses each term in the division
                ForEach(terms, id: \.self.id) { term in
                    Text(String(term.id))
//                        ForEach(term.assignments, id: \.self.id) { assignment in
//
//                            HStack {
//                                Text(assignment.name)
//                                Spacer()
//
//                                Toggle(isOn: $changingMarks[assignment.id].received)
//
//                                if changingMarks[assignment.id].received {
//                                    if let unwrappedValue = changingMarks[assignment.id].value {
//                                        Text(unwrappedValue)
//                                    }
//
//                                } else {
//                                    if let unwrappedExcuse = changingMarks[assignment.id].excuse {
//                                        Text(unwrappedExcuse)
//                                    }
//
//                                }
//                            }
//                        }
                    }
                }
        }
    }
}

struct StudentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItem(changingMarks: Division.currentExamples[0].students[0].marks, terms: Division.currentExamples[0].terms)
    }
}
