//
//  MainView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var state: StateController
    
    var body: some View {
        NavigationView {
            List(state.currentDivisions, id: \.self.name) { division in
                NavigationLink(destination: DivisionView(division: division)) {
                    DivisionItem(division: division)
                }
            }
            .navigationTitle("Classes")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StateController.example)
    }
}
