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
            
            //Text("Classes")
                //.font(.largeTitle)
                        
            NavigationView {
                List {
                    ForEach(state.currentDivisions, id: \.self.name) {
                        NavigationLink(destination: DivisionView(division: $0)) {
                            DivisionItem(division: $0, editing: editing)
                        }
                    }//.onDelete()
                }
                .navigationTitle("Classes")
                .toolbar {
                    EditButton()
                }
                
                // get navigation view to be normal on ipad
            }
            
             
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StateController.example)
    }
}
