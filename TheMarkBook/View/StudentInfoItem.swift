//
//  StudentInfoItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentInfoItem: View {
    
    @State var student: Student
    @State var changingName: String = ""
    @State var changingDateOfBirth: Date = Date()
    @State var changingContactInfo: String = ""
    
    var body: some View {
        
        VStack {
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
        .onAppear(perform: {
            assignVariables()
        })
        .onDisappear(perform: {
            saveToState()
        })
        
    }
    
    func assignVariables() {
        changingName = student.name
        changingDateOfBirth = student.dateOfBirth
        changingContactInfo = student.contactInfo
    }
    
    func saveToState() {
        student.name = changingName
        student.dateOfBirth = changingDateOfBirth
        student.contactInfo = changingContactInfo
    }
    
}

struct StudentInfoItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoItem(student: Student.example)
    }
}
