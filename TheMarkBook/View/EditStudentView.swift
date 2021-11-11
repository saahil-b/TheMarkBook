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
    
    @State var editingName: Bool = false
    
    @State var changingName: String = ""
    
    
    @State var dateOfBirth: Date = Date()
    var contactInfo: String = ""
    var marks: [Int:Mark] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Edit Student Info")
                .font(.largeTitle)
            
            Spacer()
            
            Text("ID:       #\(division.students[studentIndex].id)")
            Text("Class:    \(division.name)")
            
            Spacer()
        
            HStack {
                Text("Name")
                
                Spacer()
                
                TextField(
                    "Student name",
                    text: $changingName,
                    
                    onCommit: {
                        division.students[studentIndex].name = changingName
                        editingName.toggle()
                    })
            }
            
            HStack {
                DatePicker(
                    "Date of birth",
                    selection: $dateOfBirth,
                    // bind this
                    displayedComponents: [.date]
                )
                
                //Text(division.students[studentIndex].dateOfBirth, style: .date)
            }
            
            HStack {
                Text("Contact Info")
                Spacer()
                Text(division.students[studentIndex].contactInfo)
            }
            
            Spacer()
            
        }
        .onAppear(perform: {
            changingName = division.students[studentIndex].name
        })
        
    }
    
    func updateStudentView() {
        //
    }
    
}

struct EditStudentView_Previews: PreviewProvider {
    static var previews: some View {
        EditStudentView(studentIndex: 0, division: Division.currentExamples[0])
    }
}
