//
//  StudentItem.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 07/01/2022.
//

import SwiftUI

struct StudentItem: View {
    
    var student: Student
    
    var body: some View {
        Text(student.name)
    }
}

struct StudentItem_Previews: PreviewProvider {
    static var previews: some View {
        StudentItem(student: Student.example)
    }
}
