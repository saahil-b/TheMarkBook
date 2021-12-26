//
//  AssignmentInfoItem.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 12/12/2021.
//

import SwiftUI

struct AssignmentInfoItem: View {
    
    @EnvironmentObject var cc: CustomColour
    
    var assignment: Assignment
    
    @State var changingName: String = ""
    @State var changingDate: Date = Date()
    @State var changingTopic: String = ""
    @State var changingMaximumMark: Double = 0
    
    @State var displayedMaximumMark: String = ""
    
    let passInfoBackToEditAssignmentView: (String, Date, String, Double) -> Void
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text("Name")
                Spacer()
                TextField("Assignment name", text: $changingName)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                DatePicker(
                    "Due date",
                    selection: $changingDate,
                    displayedComponents: [.date]
                )
                .accentColor(cc.body)
            }
            
            HStack {
                Text("Topic")
                Spacer()
                TextField("Topic", text: $changingTopic)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Maximum mark")
                Spacer()
                TextField("Maximum mark",
                          text: $displayedMaximumMark,
                          onCommit: {
                            if let x = Double(displayedMaximumMark) {
                                changingMaximumMark = x
                            } else {
                                changingMaximumMark = 0
                                displayedMaximumMark = "0"
                            }
                          })
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            
        }
        .onAppear(perform: { assignVariables() })
        .onDisappear(perform: { saveToState() })
        
    }
    
    func assignVariables() {
        changingName = assignment.name
        changingDate = assignment.date
        changingTopic = assignment.topic
        changingMaximumMark = assignment.maximumMark
        
        displayedMaximumMark = String(assignment.maximumMark)
    }
    
    func saveToState() {
        passInfoBackToEditAssignmentView(changingName, changingDate, changingTopic, changingMaximumMark)
    }
    
}

struct AssignmentInfoItem_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentInfoItem(assignment: StateController.example.currentDivisions[0].terms[0].assignments[0], passInfoBackToEditAssignmentView: {_,_,_,_ in})
    }
}
