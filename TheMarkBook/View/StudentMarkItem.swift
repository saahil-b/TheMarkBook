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
    @State var changingReceived: Bool = false
    
    @State var assignment: Assignment
    
    @State var passMarkBackToEditStudentView: (Mark, Int) -> Void
    
    var body: some View {
        HStack {
            
            Text("\(assignment.name)")
            
            Spacer()
            
            Toggle("", isOn: $changingReceived)
                .onChange(of: changingReceived) { value in
                    if value {
                        displayMark = "0"
                        passMarkBackToEditStudentView(Mark(value: 0, excuse: nil, received: changingReceived), assignment.id)
                    } else {
                        displayMark = "Excused"
                        passMarkBackToEditStudentView(Mark(value: nil, excuse: displayMark, received: changingReceived), assignment.id)
                    }
                }
            
            if changingReceived {

                TextField(
                    "",
                    text: $displayMark,
                
                    onCommit: {
                        displayMark = displayMark.filter { $0.isNumber }
                        if displayMark == "" {
                            displayMark = "0"
                        }
                        
                        if let value = Int(displayMark) {
                            passMarkBackToEditStudentView(Mark(value: value, excuse: nil, received: changingReceived), assignment.id)
                        } else {
                            passMarkBackToEditStudentView(Mark(value: 0, excuse: nil, received: changingReceived), assignment.id)
                        }
                        
                    })
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)

            } else {
                
                TextField(
                    "",
                    text: $displayMark,
                    
                    onCommit: {
                        passMarkBackToEditStudentView(Mark(value: nil, excuse: displayMark, received: changingReceived), assignment.id)
                    })
                    .multilineTextAlignment(.trailing)
            }
                     
        }
        .onAppear(perform: {
            assignVariables()
        })
        .onDisappear(perform: {
            //saveToState()
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
    
//    func saveToState() {
//
//        var value: Int? = nil
//        var excuse: String? = nil
//
//        if changingReceived {
//            value = Int(displayMark)
//        } else {
//            excuse = displayMark
//        }
//
//        passMarkBackToEditStudentView(Mark(value: value, excuse: excuse, received: changingReceived), assignment.id)
//
//    }
    
}

struct StudentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItem(student: Division.currentExamples[0].students[0], assignment: Division.currentExamples[0].terms[0].assignments[0], passMarkBackToEditStudentView: {_,_  in })
    }
}
