//
//  TermItem.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 10/12/2021.
//

import SwiftUI

struct TermItem: View {
    
    @State var term: Term
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: EditTermView(), label: { Text(term.name) })
            
            List {
                ForEach(term.assignments, id: \.self.id) { assignment in
                    NavigationLink(destination: EditAssignmentView()) {
                            Text(assignment.name)
                    }
                }
            }
        }
        
    }
}

struct TermItem_Previews: PreviewProvider {
    static var previews: some View {
        TermItem(term: StateController.example.currentDivisions[0].terms[0])
    }
}
