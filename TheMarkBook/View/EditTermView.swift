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
    
    var body: some View {
        
        VStack {
            
            Text(division.terms[termIndex].name)
        
            List {
                ForEach(division.terms[termIndex].assignments, id: \.self.id) { assignment in
                    Text(assignment.name)
                }
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
        
    func addNewAssignment() {
        division.addAssignment(name: "New Assignment", date: Date(), topic: "topic", termIndex: termIndex)
    }
    
}

struct EditTermView_Previews: PreviewProvider {
    static var previews: some View {
        EditTermView(division: StateController.example.currentDivisions[0], termIndex: 0)
    }
}
