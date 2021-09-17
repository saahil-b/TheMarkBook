//
//  ArchiveView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 17/09/2021.
//

import SwiftUI

struct ArchiveView: View {
    
    @EnvironmentObject var state: StateController
    
    var body: some View {
        Text("hi")
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
            .environmentObject(StateController.example)
    }
}
