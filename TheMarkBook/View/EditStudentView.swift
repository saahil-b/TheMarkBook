//
//  EditStudentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 15/10/2021.
//

import SwiftUI

struct EditStudentView: View {
    
    let student: Student
    let divName: String
    
    var name: String = ""
    var dateOfBirth: Date = Date()
    var contactInfo: String = ""
    var marks: [Int:Mark] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Edit Student Info")
                .font(.largeTitle)
            
            Spacer()
            
            Text("ID:       #\(student.id)")
            Text("Class:    \(divName)")
            
            Spacer()
        
            HStack {
                Text("Name")
                Spacer()
                Text(student.name)
            }
            
            HStack {
                Text("Date of birth")
                Spacer()
                Text(student.dateOfBirth, style: .date)
            }
            
            HStack {
                Text("Contact Info")
                Spacer()
                Text(student.contactInfo)
            }
            
            Spacer()
            
        }
        
    }
    
    func assignInitialValues() {
        //
    }
}

struct EditStudentView_Previews: PreviewProvider {
    static var previews: some View {
        EditStudentView(student: Student.example, divName: "div name")
    }
}
