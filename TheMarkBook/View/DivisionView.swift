//
//  DivisionView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionView: View {
    
    @EnvironmentObject var state: StateController
    
    @EnvironmentObject var cc: CustomColour
    
    @State var division: Division
    
    @State var renaming: Bool = false
    @State var previousName: String = "New class"
    @State var currentName: String = "New class"
    
    @State var updateDivisionName: (String) -> Void
    
    // mainview doesn't immediately save
    
    var body: some View {
        
        ZStack {
        
            cc.back1.edgesIgnoringSafeArea(.all)
                        
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
                .foregroundColor(cc.title)
                
                Button(action: {
                    renameDivision(name: previousName)
                    renaming.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(cc.accent)
                })
                
            } else {
                
                Text(division.name)
                    .font(.largeTitle)
                    .foregroundColor(cc.title)
                
                Button(action: {
                    renaming.toggle()
                    previousName = division.name
                    currentName = division.name
                    
                }, label: {
                    Image(systemName: "pencil")
                        .foregroundColor(cc.accent)
                })
            }
            
            
            TabView {
                StudentView(division: division,saveDivisionToState: saveDivisionToState)
                    .tabItem {
                        Image(systemName: "graduationcap")
                        Text("Students")
                    }

                AssignmentView(division: division, saveDivisionToState: saveDivisionToState)
                    .tabItem {
                        Image(systemName: "tray.full")
                        Text("Assignments")
                    }

            }
            
        }
        .onAppear(perform: {
//            UITableView.appearance().backgroundColor = UIColor(cc.uiBack
        })
            
        }

    }
    
    func renameDivision(name: String) {
        state.renameDivision(name: name, id: division.id)
        updateDivisionName(name)
        localSave()
    }
    
    func saveDivisionToState(division: Division) {
        state.saveDivisionData(division: division, id: division.id)
        localSave()
    }
    
    func localSave() {
        state.saveToFile()
    }
        
}

struct DivisionView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionView(division: StateController.example.currentDivisions[0], updateDivisionName: {_ in })
            .environmentObject(StateController.example)
            .environmentObject(CustomColour.initial)
    }
}
