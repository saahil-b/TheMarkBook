//
//  StudentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct StudentView: View {
    
    @EnvironmentObject var state: StateController
    @State var index: Int
        
    var body: some View {
        VStack {
            
            Text("Students")
            
//            NavigationView {
//
//                List {
//                    // accesses each student in the division
//                    ForEach(Array(state.currentDivisions[index].students.enumerated()), id: \.self.offset) { i, student in
//                        NavigationLink(destination: EditStudentView() ) {
//                            // separate view class
//                            StudentItem(student: student)
//
//                        }
//
//                    } // defines functions for actions performed on list
//                    .onMove(perform: moveStudent)
//                    .onDelete(perform: deleteStudent)
//
//                } // adds buttons to top of menu
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        // edit button
//                        EditButton()
//                    }
//
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        // button for adding new student
//                        Button(action: { addNewStudent() }, label: {
//                            Image(systemName: "plus")
//                        })
//                    }
//
//                }
//                
//            }
        }
    }
    
    // function called onMove()
    func moveStudent(from source: IndexSet, to destination: Int) {
        // calls move function defined in state
        //state.moveCurrentDivision(fromOffsets: source, toOffset: destination)
    }
    
    // function called onDelete
    func deleteStudent(at offsets: IndexSet) {
        for i in offsets {
            state.currentDivisions[index].students.remove(at: i)
        }
    }
    
    func addNewStudent() {
        //
    }
    
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(index: 0)
            .environmentObject(StateController.example)
    }
}
