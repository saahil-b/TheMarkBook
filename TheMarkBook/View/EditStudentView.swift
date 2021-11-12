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
            
            Text("Edit Student")
                .font(.largeTitle)
            
            Spacer()
            
            Text("ID:       #\(division.students[studentIndex].id)")
            Text("Class: \(division.name)")
            
            Spacer()
            
            Group {
                Text("Info")
                    .font(.title)
                
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Student name", text: $changingName)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    DatePicker(
                        "Date of birth",
                        selection: $changingDateOfBirth,
                        displayedComponents: [.date]
                    )
                }
                
                HStack {
                    Text("Contact Info")
                    Spacer()
                    TextField("Contact Info", text: $changingContactInfo)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Spacer()
            
            Group {
                
                Text("Marks")
                    .font(.title)
                                
                List {
                    // accesses each term in the division
                    ForEach(Array(division.terms), id: \.self.id) { term in
                            ForEach(Array(term.assignments), id: \.self.id) { assignment in
                                
                                var mark = changingMarks[assignment.id]
                                
                                HStack {
                                    Text(assignment.name)
                                    Spacer()
                                    
                                    if mark.excuse == nil {
                                        if let unwrappedValue = mark.value {
                                            Text(unwrappedValue)
                                        }
                                        
                                        
                                    } else {
                                        if let unwrappedExcuse = mark.excuse {
                                            Text(unwrappedExcuse)
                                        }
                                        
                                    }
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
