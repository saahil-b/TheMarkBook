//
//  StudentMarkItemSmaller.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 03/12/2021.
//

import SwiftUI

struct StudentMarkItemSmaller: View {
    @State var student: Student
    @State var displayMark: String = ""
    @State var changingReceived: Bool = false
    
    @State var assignment: Assignment
    
    var body: some View {
        HStack {
            
            Text("\(assignment.name)")
            
            Spacer()
            
            Toggle("", isOn: $changingReceived)
                .onChange(of: changingReceived) { value in
                    if value {
                        displayMark = "0"
                    } else {
                        displayMark = "Excused"
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
                    })
                    .keyboardType(.decimalPad)

            } else {
                
                TextField("", text: $displayMark)
                
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
        
        let _ = Mark(value: value, excuse: excuse, received: changingReceived)
                
        // passMarksBackToeditStudentView(mark: Mark(value: value, excuse: excuse, received: changingReceived), assignmentID: assignment.id)
        
    }
}

struct StudentMarkItemSmaller_Previews: PreviewProvider {
    static var previews: some View {
        StudentMarkItemSmaller(student: Division.currentExamples[0].students[0], assignment: Division.currentExamples[0].terms[0].assignments[0])
    }
}
