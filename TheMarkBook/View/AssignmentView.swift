//
//  AssignmentView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 04/10/2021.
//

import SwiftUI

struct AssignmentView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @State var division: Division
    
    @State var saveDivisionToState: (Division) -> Void
    
    @State var sheetVisible = false
    @State var displayType = ""
    @State var termIndexChosen = 0
    @State var assignmentIndexChosen = 0
    
    @State var refresh = false
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        
        VStack(alignment: .leading) {
            
            HStack {
                // takes user to division analysis
                Button(action: {
                    displayType = "divisionAnalysis"
                    refreshView()
                    sheetVisible = true
                }) {
                    Image(systemName: "chart.pie")
                        .frame(width: 50, height: 50)
                }
                
                Spacer()
                
                // plus button used to add new term
                Button(action: { addNewTerm() } ) {
                    Image(systemName: "plus")
                        .frame(width:50, height: 50)
                }
                
            }.foregroundColor(cc.accent)
                    
            List {
                // accesses each term in the division
                ForEach(Array(division.terms.enumerated()), id: \.self.offset) { i, term in
                    
                    // divides list into sections for each term
                    Section(header:
                        ZStack {
                            
                            cc.back2.edgesIgnoringSafeArea(.all)
                                    
                        Menu(term.name) {
                            Button(action: {
                                // stores index of relevant student
                                termIndexChosen = i
                                // makes sure EditTermView will be shown
                                displayType = "editTerm"
                                refreshView()
                                // presents sheet
                                sheetVisible = true
                            }, label: {
                                
                                Text("Edit Term")
                                    
                            })
                            
                            Button(action: {
                                // stores index of relevant student
                                termIndexChosen = i
                                // makes sure EditTermView will be shown
                                displayType = "termAnalysis"
                                refreshView()
                                // presents sheet
                                sheetVisible = true
                            }, label: {
                                Text("Analyse Term")
                            })
                            
                        }.foregroundColor(cc.body)
                            
                        }) {
                        
                            // accesses each assignment in a term
                            ForEach(Array(term.assignments.enumerated()), id: \.self.offset) { j, assignment in
                                Button(action: {
                                    // stores indexes of relevant items
                                    termIndexChosen = i
                                    assignmentIndexChosen = j
                                    // makes sure EditTermView will be shown
                                    displayType = "editAssignment"
                                    refreshView()
                                    // presents sheet
                                    sheetVisible = true
                                }, label: {
                                    AssignmentViewItem(assignment: assignment, termIndex: i, assignmentIndex: j, updateAssignment: updateAssignment)
                                })
                                
                            }
                            .listRowBackground(cc.back1)
                            
                    }.background(cc.back1.edgesIgnoringSafeArea(.all))
                    
                }.listRowBackground(cc.back2)
                
            }
//            .listStyle(GroupedListStyle())
            
            if refresh {}
            
        }
        .accentColor(cc.accent)
        .fullScreenCover(isPresented: $sheetVisible) {
            switch displayType {
            case "divisionAnalysis":
                DivisionAnalysisView(analysis: DivisionAnalyser(division: division))
            case "editTerm":
                EditTermView(term: division.terms[termIndexChosen], termIndex: termIndexChosen, assignmentIDManager: division.assignmentIDManager.returnDuplicate(), saveChanges: saveChanges, deleteTerm: deleteTerm)
            case "termAnalysis":
                TermAnalysisView(analysis: TermAnalyser(term: division.terms[termIndexChosen], division: division ))
            case "editAssignment":
                EditAssignmentView(termIndex: termIndexChosen, assignmentIndex: assignmentIndexChosen, division: division, updateAssignment: updateAssignment)
            default:
                DismissView()
            }
        }
            
        }
        
    }
    
    
    func addNewTerm() {
        division.addTerm()
        division.terms[division.terms.count - 1].addAssignment(name: "New Assignment", date: Date(), topic: "topic", id: division.assignmentIDManager.generateNewID())
        
        let defaultMarks = division.returnDefaultMarks()
        
        for assignment in division.terms[division.terms.count - 1].assignments {
            assignment.updateMarks(marks: defaultMarks)
            division.updateStudentWithAssignmentMarkChanges(marks: defaultMarks, assignmentID: assignment.id)
        }
        
        saveDivisionToState(division)
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
        saveDivisionToState(division)
    }
    
    func updateAssignment(termIndex: Int, assignmentIndex: Int, assignment: Assignment) {
        division.terms[termIndex].assignments[assignmentIndex] = assignment
        division.updateStudentWithAssignmentMarkChanges(marks: assignment.marks, assignmentID: assignment.id)
        saveDivisionToState(division)
    }
    
    func deleteTerm(index: Int) {
        division.removeTerm(index: index)
        saveDivisionToState(division)
    }
    
    func refreshView() {
        refresh.toggle()
    }
    
}

struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(division: StateController.example.currentDivisions[0], saveDivisionToState: {_ in})
            .environmentObject(CustomColour.initial)
    }
}
