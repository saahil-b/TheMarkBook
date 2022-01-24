//
//  TheMarkBookApp.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import SwiftUI

@main
struct TheMarkBookApp: App {
    //let persistenceController = PersistenceController.shared
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(CustomColour.initial.back1)
//        UITableView.appearance().backgroundColor = CustomColour.initial.uiBack
//        UITableViewCell.appearance().backgroundColor = UIColor.red
    }

    var body: some Scene {
        WindowGroup {
            
            MainView()
                .environmentObject(StateController.initial)
                .environmentObject(CustomColour.initial)

                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }

    }
}
