//
//  DivisionView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionView: View {
    
    @EnvironmentObject var state: StateController
    @State var index: Int
    @State var renaming: Bool = false
    @State var previousName: String = "New class"
    @State var currentName: String = "New class"
    
    // make this save
    
    var body: some View {
                
        VStack {
            
            if renaming {
                
                TextField(
                    "class name",
                    text: $currentName,
                    
                onCommit: {
                    if currentName != "" {
                        renameDivision(name: currentName)
                    } else {
                        renameDivision(name: previousName)
                    }
                    renaming.toggle()
                })
                .disableAutocorrection(true)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                
                Button(action: {
                    renameDivision(name: previousName)
                    renaming.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                })
                
            } else {
                
                Text(state.currentDivisions[index].name)
                    .font(.largeTitle)
                
                Button(action: {
                    renaming.toggle()
                    previousName = state.currentDivisions[index].name
                    currentName = state.currentDivisions[index].name
                    
                }, label: {
                    Image(systemName: "pencil")
                })
            }
            
            TabView {
                StudentView(index: index)
                    .tabItem {
                        Image(systemName: "graduationcap")
                        Text("Students")
                    }
                
                AssignmentView(index: index)
                    .tabItem {
                        Image(systemName: "tray.full")
                        Text("Assignments")
                    }
                
            }
        }
    }
    
    func renameDivision(name: String) {
        state.currentDivisions[index].name = name
    }
        
}

struct DivisionView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionView(index: 0)
            .environmentObject(StateController.example)
    }
}
