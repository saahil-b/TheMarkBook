//
//  StudentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct StudentView: View {
    
    @EnvironmentObject var state: StateController
    @State var division: Division
    
    var body: some View {
        Text("Students!")
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(division: Division.currentExamples[0])
            .environmentObject(StateController.example)
    }
}