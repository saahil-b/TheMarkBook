//
//  AssignmentMarkItem.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 12/12/2021.
//

import SwiftUI

struct AssignmentMarkItem: View {
    
    @State var assignment: Assignment
    @State var displayMark: String = ""
    @State var changingReceived: Bool = false
    
    @State var initialValueSet = false
    @State var initialDisplayMark: String = ""
    
    @State var student: Student
    
    @State var passMarkBackToEditAssignmentView: (Mark, Int) -> Void
    
    var body: some View {
        
        HStack {
            
            Text("\(student.name)")
            
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
        
    }
    
    func assignVariables() -> String? {
        if let x = assignment.marks[student.id] {
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

        passMarkBackToEditAssignmentView(Mark(value: value, excuse: excuse, received: changingReceived), student.id)
    }
    
}

struct AssignmentMarkItem_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentMarkItem(assignment: StateController.example.currentDivisions[0].terms[0].assignments[0], student: StateController.example.currentDivisions[0].students[0], passMarkBackToEditAssignmentView: {_,_ in})
    }
}
