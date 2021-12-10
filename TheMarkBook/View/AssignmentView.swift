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
        
        VStack(alignment: .trailing) {
            
            // plus button used to add new term
            Button(action: { addTerm() } ) {
                Image(systemName: "plus")
                    .frame(width:50, height: 75)
            }
        
            List {
                // accesses each term in the division
                ForEach(Array(state.currentDivisions[index].terms.enumerated()), id: \.self.offset) { i, term in
                    
                    // divides list into sections for each term
                    Section(header: NavigationLink(destination: EditTermView(division: state.currentDivisions[index], termIndex: i ), label: { Text(term.name) }) ) {
                        
                        // accesses each assignment in a term
                        ForEach(term.assignments, id: \.self.id) { assignment in
                            NavigationLink(destination: EditAssignmentView()) {
                                HStack {
                                    Text(assignment.name)
                                    
                                    Spacer()
                                    
                                    Text(String(assignment.returnAverageMark()))
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
            
            
        }
    }
    
    
    func addTerm() {
        //
    }
    
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(index: 0)
        .environmentObject(StateController.example)
    }
}
