//
//  StudentMarkItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentMarkItem: View {
    
    @State var student: Student
    @State var changingMarks: [Int:Mark] = [:]
    @State var terms: [Term] = []
    
    var body: some View {
        VStack {
            Text("Marks")
                .font(.title)
            
//            List {
//                ForEach(changingMarks.map{$0.key}.indices) { index in
//                    Section(header: Text(String(changingMarks.map{$0.key}[index]))) {
//                        Text("hi")
//                    }
//                }
//            }
                     
                  
            List {
                // accesses each term in the division
                ForEach(terms, id: \.self.id) { term in
                    Section(header: Text(term.name)) {
                        ForEach(term.assignments, id: \.self.id) { assignment in
                            HStack {
                                Text(assignment.name)

                                Spacer()
                                
                                Text(String(assignment.id))

                                if let mark = assignment.marks[student.id] {

                                    if mark.received {

                                        Button(action: { mark.haveNotReceived() }, label: {
                                            Image(systemName: "archivebox")
                                        })

                                        Text("\(mark.returnUnwrappedValue())")

                                    } else {

                                        Button(action: { mark.haveReceived() }, label: {
                                            Image(systemName: "xmark.bin")
                                        })

                                        Text("\(mark.returnUnwrappedExcuse())")
                                    }

                                } else {
                                    Text("Error")
                                }

                            }
                        }
                    }
                }
            }
            
        }
        .onAppear(perform: {
            assignVariables()
        })
        .onDisappear(perform: {
            saveToState()
        })
    }
    
    func assignVariables() {
        changingMarks = student.marks
    }
    
    func saveToState() {
        student.marks = changingMarks
    }
    
}

struct StudentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItem(student: Division.currentExamples[0].students[0], terms: Division.currentExamples[0].terms)
    }
}
