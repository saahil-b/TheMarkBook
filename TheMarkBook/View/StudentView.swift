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
    
    @State var editing: Bool = false {
        didSet {
            if editing {
                editMode = EditMode.active
            } else {
                editMode = EditMode.inactive
            }
        }
    }
    
    @State var editMode = EditMode.inactive
        
    var body: some View {
        VStack(alignment: .trailing) {
            
            HStack() {
                
                Button(action: { editing.toggle() }, label: {
                    if !editing {
                        Text("Edit")
                            .frame(width:50, height: 50)
                    } else {
                        Text("Done")
                            .frame(width:50, height: 50)
                    }
                })

                
                Button(action: { addNewStudent() }, label: {
                    Image(systemName: "plus")
                        .frame(width:50, height: 50)
                })
                
            }
            

            List {
                // accesses each student in the division
                ForEach(Array(state.currentDivisions[index].students.enumerated()), id: \.self.offset) { i, student in
                    NavigationLink(destination: EditStudentView(studentIndex: i, division: state.currentDivisions[index]) ) {
                        // separate view class
                        StudentItem(student: student)

                    }

                } // defines functions for actions performed on list
                .onMove(perform: moveStudent)
                .onDelete(perform: deleteStudent)

            } // binding
            .environment(\.editMode, $editMode)
                
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
                
            
        }
        
    }
    
    // function called onMove()
    func moveStudent(from source: IndexSet, to destination: Int) {
        // calls move function defined in state
        state.currentDivisions[index].moveStudent(fromOffsets: source, toOffset: destination)
    }
    
    // function called onDelete
    func deleteStudent(at offsets: IndexSet) {
        for i in offsets {
            state.currentDivisions[index].removeStudent(index: i)
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
