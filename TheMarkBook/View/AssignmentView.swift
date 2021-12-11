//
//  AssignmentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct AssignmentView: View {
    
    @State var divIndex: Int
    @State var division: Division
    
    @State var saveDivisionToState: (Int, Division) -> Void
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            
            // plus button used to add new term
            Button(action: { addTerm() } ) {
                Image(systemName: "plus")
                    .frame(width:50, height: 75)
            }
        
            List {
                // accesses each term in the division
                ForEach(Array(division.terms.enumerated()), id: \.self.offset) { i, term in
                    
                    // divides list into sections for each term
                    Section(header: NavigationLink(destination: EditTermView(division: division, termIndex: i, updateTerm: updateTerm ), label: { Text(term.name) }) ) {
                        
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
    
    func updateTerm(position: Int, term: Term) {
        division.terms[position] = term
        saveDivisionToState(divIndex, division)
    }
    
    func updateAssignment(termIndex: Int, assignmentIndex: Int, assignment: Assignment) {
        division.terms[termIndex].assignments[assignmentIndex] = assignment
        saveDivisionToState(divIndex, division)
    }
    
    
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(divIndex: 0, division: StateController.example.currentDivisions[0], saveDivisionToState: {_,_ in})
    }
}
