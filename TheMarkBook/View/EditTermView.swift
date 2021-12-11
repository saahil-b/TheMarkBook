//
//  EditTermView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 10/12/2021.
//

import SwiftUI

struct EditTermView: View {
    
    @State var division: Division
    @State var termIndex: Int
    
    var updateTerm: (Int, Term) -> Void
    
    var body: some View {
        
        VStack {
            
            Text(division.terms[termIndex].name)
        
            List {
                ForEach(division.terms[termIndex].assignments, id: \.self.id) { assignment in
                    Text(assignment.name)
                }
                .onMove(perform: moveAssignment )
                .onDelete(perform: removeAssignment )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // edit button
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    // button for adding new division
                    Button(action: { addNewAssignment() }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            
        }
    }
    
    // function called onMove
    func moveAssignment(from source: IndexSet, to destination: Int) {
        // calls move function defined in term
        division.terms[termIndex].moveAssignment(fromOffsets: source, toOffset: destination)
    }
    
    // function called onDelete
    func removeAssignment(at offsets: IndexSet) {
        for i in offsets {
            // calls delete function defined in term
            division.terms[termIndex].removeAssignment(index: i)
        }
    }
        
    func addNewAssignment() {
        // calls function defined in division
        division.addAssignment(name: "New Assignment", date: Date(), topic: "topic", termIndex: termIndex)
        refreshView()
    }
    
    func refreshView() {
        division.refresh = "refresh EditTermView"
    }
    
    
    
}

struct EditTermView_Previews: PreviewProvider {
    static var previews: some View {
        EditTermView(division: StateController.example.currentDivisions[0], termIndex: 0, updateTerm: {_,_ in})
    }
}
