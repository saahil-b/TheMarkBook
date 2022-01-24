//
//  AssignmentViewItem.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 21/01/2022.
//

import SwiftUI

struct AssignmentViewItem: View {
    
    @EnvironmentObject var cc: CustomColour
    
    var assignment: Assignment
    var termIndex: Int
    var assignmentIndex: Int
    
    var updateAssignment: (Int, Int, Assignment) -> Void
    
    @State var changingActive = false
    @State var displayScore = ""
    
    var body: some View {
        HStack {
            
            Text(assignment.name)
            
            Spacer()
            
            Toggle("", isOn: $changingActive)
            .onChange(of: changingActive) { value in
                if changingActive {
                    displayScore = "\(Int(round(assignment.returnAveragePercentageMark()*100)))%"
                } else {
                    displayScore = "-    "
                }
                saveToState()
            }
            .toggleStyle(SwitchToggleStyle(tint: cc.accent))
            
            Text(displayScore)
                .frame(width: 100, height: 0, alignment: .trailing)
            
        }
        .onAppear(perform: {
            changingActive = assignment.active
            if changingActive {
                displayScore = "\(Int(round(assignment.returnAveragePercentageMark()*100)))%"
            } else {
                displayScore = "-    "
            }
        })
    }
    
    func saveToState() {
        assignment.active = changingActive
        updateAssignment(termIndex, assignmentIndex, assignment)
    }
    
}

struct AssignmentViewItem_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentViewItem(assignment: StateController.example.currentDivisions[0].terms[0].assignments[0], termIndex: 0, assignmentIndex: 0, updateAssignment: {_,_,_ in})
            .environmentObject(CustomColour.initial)
    }
}
