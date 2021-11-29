//
//  StudentMarkItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentMarkItem: View {
    
    @State var student: Student
    @State var changingMark: Mark = Mark.example {
        didSet {
            // assign the unwrapped variables
        }
    }
    @State var assignment: Assignment
    @State var unwrappedValue: Int = 0
    @State var unwrappedExcuse: String = ""
    
    var body: some View {
        HStack {
            
            Text("\(assignment.name)")
            
            Spacer()
            
            if changingMark.received {
                Button(action: { changingMark.haveNotReceived() }, label: {
                    Image(systemName: "archivebox.fill")
                })
                
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
        if let x = student.marks[assignment.id] {
            changingMark = x
        } else {
            changingMark = Mark(value: nil, excuse: "Error", received: false)
        }
    }
    
    func saveToState() {
        student.marks[assignment.id] = changingMark
    }
    
}

struct StudentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItem(student: Division.currentExamples[0].students[0], assignment: Division.currentExamples[0].terms[0].assignments[0])
    }
}
