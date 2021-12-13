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
            Button(action: { addNewTerm() } ) {
                Image(systemName: "plus")
                    .frame(width:50, height: 50)
            }
        
            List {
                // accesses each term in the division
                ForEach(Array(division.terms.enumerated()), id: \.self.offset) { i, term in
                    
                    // divides list into sections for each term
                    Section(header: NavigationLink(
                                destination: EditTermView(term: division.terms[i], termIndex: i, assignmentIDManager: division.assignmentIDManager.returnDuplicate(), saveChanges: saveChanges, deleteTerm: deleteTerm),
                                label: { Text(term.name) }) ) {
                        
                        // accesses each assignment in a term
                        ForEach(Array(term.assignments.enumerated()), id: \.self.offset) { j, assignment in
                            NavigationLink(destination:
                                            EditAssignmentView(termIndex: i, assignmentIndex: j, division: division, updateAssignment: updateAssignment) ) {
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
    
    
    func addNewTerm() {
        division.addTerm()
        division.addAssignment(assignment: Assignment(name: "New Assignment", date: Date(), topic: "topic", id: division.assignmentIDManager.generateNewID()), termIndex: division.terms.count - 1)
        saveDivisionToState(divIndex, division)
    }
    
    func saveChanges(termIndex: Int, term: Term, assignmentIDManager: IDManager) {
        let maxID = division.assignmentIDManager.maxID
        let defaultMarks = division.returnDefaultMarks()
                
        for assignment in term.assignments {
            if assignment.id > maxID {
                assignment.updateMarks(marks: defaultMarks)
                division.updateStudentWithAssignmentMarkChanges(marks: defaultMarks, assignmentID: assignment.id)
            }
        }
        
        division.terms[termIndex] = term
        division.assignmentIDManager = assignmentIDManager
        saveDivisionToState(divIndex, division)
    }
    
    func updateAssignment(termIndex: Int, assignmentIndex: Int, assignment: Assignment) {
        division.terms[termIndex].assignments[assignmentIndex] = assignment
        division.updateStudentWithAssignmentMarkChanges(marks: assignment.marks, assignmentID: assignment.id)
        saveDivisionToState(divIndex, division)
    }
    
    func deleteTerm(index: Int) {
        division.removeTerm(index: index)
        saveDivisionToState(divIndex, division)
    }
    
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(divIndex: 0, division: StateController.example.currentDivisions[0], saveDivisionToState: {_,_ in})
    }
}
