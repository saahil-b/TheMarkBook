//
//  StudentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct StudentView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @State var division: Division
    
    @State var saveDivisionToState: (Division) -> Void
    
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
    
    @State var refresh: Bool = false
    
    @State var sheetVisible = false
    @State var desiredView = ""
    @State var selectedIndex: Int = 0
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack(alignment: .leading) {
            
            HStack {
                Button(action: {
                    desiredView = "divisionAnalysis"
                    updateStudentView()
                    sheetVisible = true
                }, label: {
                    Image(systemName: "chart.pie")
                        .frame(width: 50, height: 50)
                })
                
                Spacer()
                
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
            .foregroundColor(cc.accent)
            
            List {
                // accesses each student in the division
                ForEach(Array(division.students.enumerated()), id: \.self.offset) { i, student in
                    
                    Menu(student.name) {
                        
                        Button(action: {
                            // stores index of relevant student
                            selectedIndex = i
                            // makes sure EditStudentView will be shown
                            desiredView = "edit"
                            updateStudentView()
                            // presents sheet
                            sheetVisible = true
                        }, label: {
                            Text("Edit Student")
                        })
                        
                        Button(action: {
                            // stores index of relevant student
                            selectedIndex = i
                            // makes sure EditStudentView will be shown
                            desiredView = "studentAnalysis"
                            updateStudentView()
                            // presents sheet
                            sheetVisible = true
                        }, label: {
                            Text("Analyse Student")
                        })
                        
                    }.foregroundColor(cc.body)
                    

                } // defines functions for actions performed on list
                .onMove(perform: moveStudent)
                .onDelete(perform: deleteStudent)
                .listRowBackground(cc.back1)

            } // binding
            .environment(\.editMode, $editMode)
            
            
            if refresh{}
            
        }
        .onAppear(perform: {
//            UITableView.appearance().backgroundColor = cc.uiBack
        })
        .fullScreenCover(isPresented: $sheetVisible) {
            switch desiredView {
            case "edit":
                EditStudentView(studentIndex: selectedIndex, division: division, updateStudent: updateStudent)
            
            case "studentAnalysis":
                StudentAnalysisView(analysis: StudentAnalyser(student: division.students[selectedIndex], division: division))
                
            case "divisionAnalysis":
                DivisionAnalysisView(analysis: DivisionAnalyser(division: division))
                
            default:
                DismissView()
            }
        }
            
        }
                        
    }
    
    
    // function called onMove()
    func moveStudent(from source: IndexSet, to destination: Int) {
        // calls move function defined in state
        division.moveStudent(fromOffsets: source, toOffset: destination)
        saveDivisionToState(division)
        updateStudentView()
    }
    
    // function called onDelete
    func deleteStudent(at offsets: IndexSet) {
        for i in offsets {
            division.removeStudent(index: i)
        }
        saveDivisionToState(division)
        updateStudentView()
    }
    
    func addNewStudent() {
        division.addStudent(name: "New Student", dateOfBirth: Date(), contactInfo: "newstudent@email.com")
        saveDivisionToState(division)
        updateStudentView()
    }
    
    func updateStudentView() {
        refresh.toggle()
    }
    
    func updateStudent(student: Student, position: Int) {
        division.students[position] = student
        division.updateAssignmentsWithStudentMarkChanges(marks: student.marks, studentID: student.id)
        saveDivisionToState(division)
        updateStudentView()
    }
    
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(division: Division.currentExamples[0], saveDivisionToState: {_ in})
            .environmentObject(CustomColour.initial)
    }
}
