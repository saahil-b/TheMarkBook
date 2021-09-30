//
//  MainView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var state: StateController
    @State private var editing: Bool = false
    
    var body: some View {
        // add archive veiw above
        VStack(alignment: .center, spacing: 10){
            
            
                        
            NavigationView {
                
                VStack {
                    Text("Classes")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    NavigationLink(destination: ArchiveView()) {
                        Text("view archive")
                    }
                    
                
                    List {
                        ForEach(state.currentDivisions, id: \.self.name) { division in
                            NavigationLink(destination: DivisionView(division: division)) {
                                DivisionItem(division: division, editing: editing)
                            }
                        }.onMove(perform: moveCurrentDivision)
                        .onDelete(perform: archiveCurrentDivision)
                    }
                    //.navigationTitle("Classes")
                    .toolbar {
                        EditButton()
                    }
                }
                
            }
             
        }
    
    }
    
    func moveCurrentDivision(from source: IndexSet, to destination: Int) {
        state.moveCurrentDivision(fromOffsets: source, toOffsets: destination)
    }
    
    func archiveCurrentDivision(at offsets: IndexSet) {
        for i in offsets {
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
