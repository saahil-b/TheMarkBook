//
//  StudentMarkItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentMarkItem: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @State var student: Student
    @State var displayMark: String = ""
    @State var changingReceived: Bool = false
    
    @State var initialValueSet = false
    @State var initialDisplayMark: String = ""
    
    @State var assignment: Assignment
    
    @State var passMarkBackToEditStudentView: (Mark, Int) -> Void
    
    var body: some View {
        
//        ZStack {
//
//            cc.back1.edgesIgnoringSafeArea(.all)
        
        HStack {
            
            Text("\(assignment.name)")
            
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
                .toggleStyle(SwitchToggleStyle(tint: cc.accent))
            
            if changingReceived {
                HStack {
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
                        .frame(width: 300, height: 0, alignment: .trailing)
                    
                    Text("/\(assignment.maximumMark)")
                        .frame(width: 70, height: 0, alignment: .leading)
                    
                }
                

            } else {
                TextField(
                    "",
                    text: $displayMark,
                    onCommit: {
                        saveToState()
                    })
                    .multilineTextAlignment(.trailing)
                    .frame(width: 370, height: 0, alignment: .trailing)

            }
                     
        }
        .onAppear(perform: {
            if let x = assignVariables() {
                initialDisplayMark = x
            }
        })
            
//        }
        
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
            .environmentObject(CustomColour.initial)
    }
}
