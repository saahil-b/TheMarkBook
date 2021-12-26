//
//  EditStudentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 15/10/2021.
//

import SwiftUI

struct EditStudentView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) var presentationMode
    
    let studentIndex: Int
    let division: Division
    
    @State var updateStudent: (Student, Int) -> Void
        
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack(alignment: .leading) {
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Label("Back", systemImage: "chevron.left")
            }
            .foregroundColor(cc.accent)
            
            Section {
                Text("Edit Student")
                    .font(.largeTitle)
                    .foregroundColor(cc.title)
                Text("ID:       #\(division.students[studentIndex].id)")
                Text("Class: \(division.name)")
            }
            
                        
            Section(header: Text("Info").font(.title).foregroundColor(cc.title)) {
                StudentInfoItem(student: division.students[studentIndex],
                                passInfoBackToEditStudentView: passInfoBackToEditStudentView)
            }
            
                        
            Section(header: Text("Marks").font(.title).foregroundColor(cc.title)) {
                
                List {
                    ForEach(division.terms, id: \.self.id) { term in
                        Section(header:
                                    
                    ZStack {
                        
                        cc.back2.edgesIgnoringSafeArea(.all)
                        
                        Text(term.name)
                        
                    }) {
                            ForEach(term.assignments, id: \.self.id) { assignment in
                                StudentMarkItem(student: division.students[studentIndex], assignment: assignment, passMarkBackToEditStudentView: passMarkBackToEditStudentView)
                            }.listRowBackground(cc.back1)
                        }
                    }
                }
            }
            
        }
        .padding()
        .onDisappear(perform: { saveToState() })
            
        }
        
    }
    
    func passInfoBackToEditStudentView(name: String, dateOfBirth: Date, contactInfo: String) {
        division.students[studentIndex].name = name
        division.students[studentIndex].dateOfBirth = dateOfBirth
        division.students[studentIndex].contactInfo = contactInfo
        saveToState()
    }
    
    func passMarkBackToEditStudentView(mark: Mark, assignmentID: Int) {
        division.students[studentIndex].marks[assignmentID] = mark
        saveToState()
    }
    
    func saveToState() {
        updateStudent(division.students[studentIndex], studentIndex)
    }
    
}

struct EditStudentView_Previews: PreviewProvider {
    static var previews: some View {
        EditStudentView(studentIndex: 0, division: Division.currentExamples[0], updateStudent: {_,_  in } )
            .environmentObject(CustomColour.initial)
    }
}
