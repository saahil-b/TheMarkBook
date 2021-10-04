//
//  AssignmentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct AssignmentView: View {
    
    @EnvironmentObject var state: StateController
    @State var division: Division
    
    var body: some View {
        Text("Assignments!")
    }
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(division: Division.currentExamples[0])
        .environmentObject(StateController.example)
    }
}
