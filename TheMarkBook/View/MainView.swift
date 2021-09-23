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
    //@Binding var editingBinding: Bool
    
    //@State var imageName: String = "pencil"
    
    var body: some View {
        // add archive veiw above
        VStack(alignment: .center, spacing: 10){
            
            //Text("Classes")
                //.font(.largeTitle)
                        
            NavigationView {
                List(state.currentDivisions, id: \.self.name) { division in
                    NavigationLink(destination: DivisionView(division: division)) {
                        DivisionItem(division: division, editing: $editing)
                    }
                }.navigationTitle("Classes")
                
                // get navigation view to be normal on ipad
            }
            
            Spacer()
            
            Button(action: {
                editing = !editing
            
            }) {

                Image(systemName: "\(editing ? "x" : "pencil").circle")
                    .imageScale(.large)
                // get it bigger
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
