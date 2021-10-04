//
//  DivisionView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionView: View {
    
    @State var division: Division
    
    var body: some View {
        VStack {
            Text(division.name)
                .font(.largeTitle)
            
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
        
}

struct DivisionView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionView(division: Division.currentExamples[0])
    }
}
