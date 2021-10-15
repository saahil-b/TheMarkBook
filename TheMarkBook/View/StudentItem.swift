//
//  StudentItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 15/10/2021.
//

import SwiftUI

struct StudentItem: View {
    
    @State var student: Student
    
    var body: some View {
        Text(student.name)
    }
}

struct StudentItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentItem(student: Student.example)
    }
}
