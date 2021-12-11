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
    
    @State var initialValueSet = false
    @State var initialDisplayMark: String = ""
    
    @State var assignment: Assignment
    
    @State var passMarkBackToEditStudentView: (Mark, Int) -> Void
    
    var body: some View {
        HStack {
            
            Text("\(assignment.name)")
//            Text("\(assignment.id)")
            
            Spacer()
            
            Toggle("", isOn: $changingReceived)
                .onChange(of: changingReceived) { value in
                    
                    if initialValueSet == true {
                        if value {
                            displayMark = "0"
                        } else {
                            displayMark = "Excused"
                        }
                        
                        saveToState()
                        
                    } else {
                        displayMark = initialDisplayMark
                        initialValueSet = true
                    }
                                        
                }
            
            if changingReceived {

                TextField(
                    "",
                    text: $displayMark,
                
                    onCommit: {
                        
                        if let _ = Double(displayMark) {
                            //
                        } else {
                            displayMark = "0"
                        }
                        
                        saveToState()
                        
                    })
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)

            } else {
                
                TextField(
                    "",
                    text: $displayMark,
                    
                    onCommit: {
                        saveToState()
                    })
                    .multilineTextAlignment(.trailing)
            }
                     
        }
        .onAppear(perform: {
            if let x = assignVariables() {
                initialDisplayMark = x
            }
        })
        .onDisappear(perform: {
//            saveToState()
        })
    }
    
    func assignVariables() -> String? {
        if let x = student.marks[assignment.id] {
            changingReceived = x.received
            
            if changingReceived {
                return String(x.returnUnwrappedValue())
                
            } else {
                displayMark = x.returnUnwrappedExcuse()
                initialValueSet = true
            }
            
            
        } else {
            changingReceived = false
            displayMark = "Problem unwrapping from state"
        }
        
        return nil
        
    }
    
    func saveToState() {

        var value: Double? = nil
        var excuse: String? = nil

        if changingReceived {
            if let x = Double(displayMark) {
                value = x
            } else {
                value = 0
            }
            
        } else {
            excuse = displayMark
        }
        
        print(displayMark)

        passMarkBackToEditStudentView(Mark(value: value, excuse: excuse, received: changingReceived), assignment.id)

    }
    
}

struct StudentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItem(student: Division.currentExamples[0].students[0], assignment: Division.currentExamples[0].terms[0].assignments[0], passMarkBackToEditStudentView: {_,_  in })
    }
}
