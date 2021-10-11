//
//  AssignmentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct AssignmentView: View {
    
    @EnvironmentObject var state: StateController
    @State var index: Int
    
    var body: some View {
        Text("Assignments!")
    }
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(index: 0)
        .environmentObject(StateController.example)
    }
}
