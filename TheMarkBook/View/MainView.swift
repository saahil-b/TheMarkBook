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
                        ForEach(state.currentDivisions, id: \.self.name) { division in
                            
                            NavigationLink(destination: DivisionView(division: division)) {
                                
                                // separate view class
                                DivisionItem(division: division)
            
                            }
                            
                        } // defines functions for actions performed on list
                        .onMove(perform: moveCurrentDivision)
                        .onDelete(perform: archiveCurrentDivision)
                        
                    } // adds edit button on top of menu
                    .toolbar {
                        EditButton()
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
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StateController.example)
    }
}
