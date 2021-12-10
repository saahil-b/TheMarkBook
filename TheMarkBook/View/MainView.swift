//
//  MainView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import SwiftUI

struct MainView: View {
    
    // allows acces to stateController
    @EnvironmentObject var state: StateController
        
    var body: some View {
                
        VStack(alignment: .center, spacing: 10){
            NavigationView {
                VStack {
                    // menu title
                    Text("Classes")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    // button to navigate to archive
                    NavigationLink(destination: ArchiveView()) {
                        Text("view archive")
                    }
                    
                    // lists division items
                    List {
                        // accesses each division in currentDivisions
                        ForEach(Array(state.currentDivisions.enumerated()), id: \.self.offset) { i, division in
                            NavigationLink(destination: DivisionView(index: i, updateDivisionName: updateDivisionName )) {
                                // separate view class
                                DivisionItem(index: i)
            
                            }
                            
                        } // defines functions for actions performed on list
                        .onMove(perform: moveCurrentDivision)
                        .onDelete(perform: archiveCurrentDivision)
                        
                    } // adds buttons to top of menu
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            // edit button
                            EditButton()
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            // button for adding new division
                            Button(action: { addNewDivision() }, label: {
                                Image(systemName: "plus")
                            })
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    // function called onMove()
    func moveCurrentDivision(from source: IndexSet, to destination: Int) {
        // calls move function defined in state
        state.moveCurrentDivision(fromOffsets: source, toOffset: destination)
    }
    
    // function called onDelete
    func archiveCurrentDivision(at offsets: IndexSet) {
        for i in offsets {
            // calls archive function defined in state
            state.archiveDivision(index: i)
        }
    }
    
    func addNewDivision() {
        state.addToCurrentDivisions(division: Division(name: "New Class"))
    }
    
    func updateDivisionName(name: String) {
//        state.currentDivisions = state.currentDivisions
        state.refresh = "refresh main view"
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StateController.example)
    }
}
