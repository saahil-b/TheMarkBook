//
//  ContentView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 24/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var state: StateController
    @EnvironmentObject var cc: CustomColour
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
            
            MainView()
            
        }
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = cc.uiBack
        })
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
