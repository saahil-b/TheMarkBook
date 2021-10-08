//
//  DivisionView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionView: View {
    
    @State var division: Division
    @State var renaming: Bool = false
    @State var previousName: String = "New class"
    @State var currentName: String = "New class"
    
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
                
                Button(action: {
                    renameDivision(name: previousName)
                    renaming.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                })
                
            } else {
                
                Text(division.name)
                    .font(.largeTitle)
                
                Button(action: {
                    renaming.toggle()
                    previousName = division.name
                    currentName = division.name
                    
                }, label: {
                    Image(systemName: "pencil")
                })
            }
            
            TabView {
                StudentView(division: division)
                    .tabItem {
                        Image(systemName: "graduationcap")
                        Text("Students")
                    }
                
                AssignmentView(division: division)
                    .tabItem {
                        Image(systemName: "tray.full")
                        Text("Assignments")
                    }
                
            }
        }
    }
    
    func renameDivision(name: String) {
        division.name = name
    }
        
}

struct DivisionView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionView(division: Division.currentExamples[0])
    }
}
