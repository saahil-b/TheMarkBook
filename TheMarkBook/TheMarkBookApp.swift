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

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(StateController.example)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
