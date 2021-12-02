//
//  StudentMarkItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentMarkItem: View {
    
    @State var student: Student
    @State var displayMark: String = ""
    @State var changingReceived: Bool = false {
        didSet {
            if changingReceived {
                displayMark = "0"
            } else {
                displayMark = "Excused"
            }
        }
    }
    @State var assignment: Assignment
    
    var body: some View {
        HStack {
            
            Text("\(assignment.name)")
            
            Spacer()
            
//            Toggle("", isOn: $changingReceived)
            
//            if changingReceived {
//
//                TextField(
//                    "",
//                    text: $displayMark
//                )
//                .keyboardType(.decimalPad)
//                .onSubmit {
//
//                }
//
//            }
                     
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
            changingReceived = x.received
            
            if changingReceived {
                displayMark = String(x.returnUnwrappedValue())
            } else {
                displayMark = x.returnUnwrappedExcuse()
            }
            
            
        } else {
            changingReceived = false
            displayMark = "0"
        }
    }
    
    func saveToState() {
        
        var value: Int? = nil
        var excuse: String? = nil
        
        if changingReceived {
            value = Int(displayMark)
        } else {
            excuse = displayMark
        }
        
        student.marks[assignment.id] = Mark(value: value, excuse: excuse, received: changingReceived)
    }
    
}

struct StudentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItem(student: Division.currentExamples[0].students[0], assignment: Division.currentExamples[0].terms[0].assignments[0])
    }
}
