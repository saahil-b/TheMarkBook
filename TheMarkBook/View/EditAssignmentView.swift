//
//  EditAssignmentView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 10/12/2021.
//

import SwiftUI

struct EditAssignmentView: View {
    
    @EnvironmentObject var cc: CustomColour
        
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let termIndex: Int
    let assignmentIndex: Int
    let division: Division
    
    var updateAssignment: (Int, Int, Assignment) -> Void
    
        
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack(alignment: .leading) {
            
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Label("Back", systemImage: "chevron.left")
                }
                .foregroundColor(cc.accent)
                
                Spacer()
            }
        
            Section {
                Text("Edit Assignment")
                    .font(.largeTitle)
                    .foregroundColor(cc.title)
                Text("ID:       #\(division.terms[termIndex].assignments[assignmentIndex].id)")
                Text("Class: \(division.name)")
            }
            
            Spacer()
                        
            Section(header: Text("Info").font(.title).foregroundColor(cc.title)) {
                AssignmentInfoItem(assignment: division.terms[termIndex].assignments[assignmentIndex], passInfoBackToEditAssignmentView: passInfoBackToEditAssignmentView)
            }
            
            
            Section(header: Text("Marks").font(.title).foregroundColor(cc.title) ) {
                List {
                    ForEach(division.students, id: \.self.id) { student in
                        AssignmentMarkItem(assignment: division.terms[termIndex].assignments[assignmentIndex], student: student, passMarkBackToEditAssignmentView: passMarkBackToEditAssignmentView )
                    }
                    .listRowBackground(cc.back1)
                }
            }
            
        }
        .foregroundColor(cc.body)
        .padding()
        .onDisappear(perform: { saveToState() })
            
        }
        
    }
    
    func passInfoBackToEditAssignmentView(name: String, date: Date, topic: String, maximumMark: Double) {
        division.terms[termIndex].assignments[assignmentIndex].name = name
        division.terms[termIndex].assignments[assignmentIndex].date = date
        division.terms[termIndex].assignments[assignmentIndex].topic = topic
        division.terms[termIndex].assignments[assignmentIndex].maximumMark = maximumMark
        saveToState()
    }

    func passMarkBackToEditAssignmentView(mark: Mark, studentID: Int) {
        division.terms[termIndex].assignments[assignmentIndex].marks[studentID] = mark
        saveToState()
    }

    func saveToState() {
        updateAssignment(termIndex, assignmentIndex, division.terms[termIndex].assignments[assignmentIndex])
    }
    
}




struct EditAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        EditAssignmentView(termIndex: 0, assignmentIndex: 0, division: Division.currentExamples[0], updateAssignment: {_,_,_ in})
    }
}
