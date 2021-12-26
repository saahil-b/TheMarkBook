//
//  EditTermView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 10/12/2021.
//

import SwiftUI

struct EditTermView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State var term: Term
    @State var termIndex: Int
    
    @State var assignmentIDManager: IDManager
    
    @State var renaming: Bool = false
    @State var previousName: String = "New term"
    @State var currentName: String = "New term"
    
    var saveChanges: (Int, Term, IDManager) -> Void
    var deleteTerm: (Int) -> Void
    
    @State var refresh: Bool = false
    
    @State private var showingAlert = false
    
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
    
    @State var doNotSave = false
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack {
            
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Label("Back", systemImage: "chevron.left")
                }
                
                Spacer()
                
                Button(action: { showingAlert = true }) {
                    Image(systemName: "trash.circle")
                        .frame(width: 50, height: 50)
                }
                
            }
            .foregroundColor(cc.accent)
                        
            if renaming {
                TextField(
                    "term name",
                    text: $currentName,
                onCommit: {
                    if currentName != "" {
                        renameTerm(name: currentName)
                    } else {
                        renameTerm(name: previousName)
                    }
                    renaming.toggle()
                })
                .foregroundColor(cc.title)
                .disableAutocorrection(true)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                
                Button(action: {
                    renameTerm(name: previousName)
                    renaming.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                })
                .foregroundColor(cc.accent)
                
            } else {
                Text(term.name)
                    .font(.largeTitle)
                    .foregroundColor(cc.title)
                
                Button(action: {
                    renaming.toggle()
                    previousName = term.name
                    currentName = term.name
                }, label: {
                    Image(systemName: "pencil")
                })
                .foregroundColor(cc.accent)
            }
            
            
            HStack {
                
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
                
                Button(action: { addNewAssignment() }, label: {
                    Image(systemName: "plus")
                        .frame(width:50, height: 50)
                })
                
            }
            .foregroundColor(cc.accent)
            
                    
            List {
                ForEach(term.assignments, id: \.self.id) { assignment in
                    Text(assignment.name)
                }
                .onMove(perform: moveAssignment )
                .onDelete(perform: removeAssignment )
                .listRowBackground(cc.back1)
            }
            .environment(\.editMode, $editMode)

            
            if refresh {}
            
        }
        .foregroundColor(cc.body)
        .padding()
        .onDisappear(perform: { if !doNotSave {saveToState()} })
        .alert(isPresented: $showingAlert) {
            Alert (
                title: Text("You are about to delete this term"),
                message: Text("This action cannot be undone"),
                primaryButton: .destructive(Text("Delete")){ deleteThisTerm() },
                secondaryButton: .cancel()
            )
        }
            
        }
    }
    
    // function called onMove
    func moveAssignment(from source: IndexSet, to destination: Int) {
        // calls move function defined in term
        term.moveAssignment(fromOffsets: source, toOffset: destination)
        refreshView()
    }
    
    // function called onDelete
    func removeAssignment(at offsets: IndexSet) {
        for i in offsets {
            // calls delete function defined in term
            term.removeAssignment(index: i)
        }
        refreshView()
    }
        
    func addNewAssignment() {
        // calls function defined in division
        let id = assignmentIDManager.generateNewID()
        term.addAssignment(name: "New Assignment", date: Date(), topic: "topic", id: id)
        refreshView()
    }
    
    func renameTerm(name: String) {
        // assigns term name
        term.name = name
    }
    
    func refreshView() {
        refresh.toggle()
    }
    
    func saveToState() {
        saveChanges(termIndex, term, assignmentIDManager)
    }
    
    func deleteThisTerm() {
        doNotSave = true
        refreshView()
        deleteTerm(termIndex)
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct EditTermView_Previews: PreviewProvider {
    static var previews: some View {
        EditTermView(term: StateController.example.currentDivisions[0].terms[0], termIndex: 0, assignmentIDManager: StateController.example.currentDivisions[0].assignmentIDManager, saveChanges: {_,_,_ in}, deleteTerm: {_ in})
    }
}
