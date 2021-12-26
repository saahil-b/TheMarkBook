//
//  StudentInfoItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 12/11/2021.
//

import SwiftUI

struct StudentInfoItem: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @State var student: Student
    @State var changingName: String = ""
    @State var changingDateOfBirth: Date = Date()
    @State var changingContactInfo: String = ""
    
    @State var passInfoBackToEditStudentView: (String, Date, String) -> Void
    
    var body: some View {
        
//        ZStack {
//
//            cc.back1.edgesIgnoringSafeArea(.all)
        
        
        VStack(alignment: .leading) {
            
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
                .accentColor(cc.body)
            }
            
            HStack {
                Text("Contact Info")
                Spacer()
                TextField("Contact Info", text: $changingContactInfo)
                    .multilineTextAlignment(.trailing)
            }
            
        }
        .onAppear(perform: { assignVariables() })
        .onDisappear(perform: { saveToState() })
            
//        }
        
    }
    
    func assignVariables() {
        changingName = student.name
        changingDateOfBirth = student.dateOfBirth
        changingContactInfo = student.contactInfo
    }
    
    func saveToState() {
        passInfoBackToEditStudentView(changingName, changingDateOfBirth, changingContactInfo)
    }
    
}

struct StudentInfoItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoItem(student: Student.example, passInfoBackToEditStudentView: {_,_,_  in })
            .environmentObject(CustomColour.initial)
    }
}
