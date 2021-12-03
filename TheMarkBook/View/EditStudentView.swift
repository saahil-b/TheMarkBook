//
//  EditStudentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 15/10/2021.
//

import SwiftUI

struct EditStudentView: View {
    
    let studentIndex: Int
    let division: Division
            
    @State var changingName: String = ""
    @State var changingDateOfBirth: Date = Date()
    @State var changingContactInfo: String = ""
    @State var changingMarks: [Int:Mark] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Section {
                Text("Edit Student")
                    .font(.largeTitle)
                Text("ID:       #\(division.students[studentIndex].id)")
                Text("Class: \(division.name)")
            }
            
            Spacer()
            
            Section(header: Text("Info").font(.title)) {
                StudentInfoItem(student: division.students[studentIndex], passInfoBackToEditStudentView: passInfoBackToEditStudentView)
            }
            
            Spacer()
            
            Section(header: Text("Marks").font(.title) ) {
                
                List {
                    ForEach(division.terms, id: \.self.id) { term in
                        Section(header: Text(term.name)) {
                            ForEach(term.assignments, id: \.self.id) { assignment in
                                StudentMarkItem(student: division.students[studentIndex], assignment: assignment, passMarkBackToEditStudentView: passMarkBackToEditStudentView)
                            }
                        }
                    }
                }
            }

        }
        .padding()
        .onAppear(perform: {
            assignVariables()
        })
        .onDisappear(perform: {
            saveToState()
        })
        
    }
    
    func assignVariables() {
        changingName = division.students[studentIndex].name
        changingDateOfBirth = division.students[studentIndex].dateOfBirth
        changingContactInfo = division.students[studentIndex].contactInfo
        changingMarks = division.students[studentIndex].marks
    }
    
    func passInfoBackToEditStudentView(name: String, dateOfBirth: Date, contactInfo: String) {
        changingName = name
        changingDateOfBirth = dateOfBirth
        changingContactInfo = contactInfo
    }
    
    func passMarkBackToEditStudentView(mark: Mark, assignmentID: Int) {
        changingMarks[assignmentID] = mark
    }
    
    func saveToState() {
        division.students[studentIndex].name = changingName
        division.students[studentIndex].dateOfBirth = changingDateOfBirth
        division.students[studentIndex].contactInfo = changingContactInfo
        division.students[studentIndex].marks = changingMarks
    }
    
}

struct EditStudentView_Previews: PreviewProvider {
    static var previews: some View {
        EditStudentView(studentIndex: 0, division: Division.currentExamples[0])
    }
}
