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
                    Section(header: Text(term.name)) {
                        ForEach(term.assignments, id: \.self.id) { assignment in
                            HStack {
                                Text(assignment.name)
//                                if let mark = changingMarks[assignment.id] {
//                                    if mark.received {
//                                        if let value = mark.value {
//                                            Text(value)
//                                        }
//
//                                    } else {
//                                        if let excuse = mark.excuse {
//                                            Text(excuse)
//                                        }
//                                    }
//
//                                } else {
//                                    Text("Error")
//                                }
//
                            }
                        }
                    }
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
