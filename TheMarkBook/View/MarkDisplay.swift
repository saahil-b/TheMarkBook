//
//  MarkDisplay.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 19/11/2021.
//

import SwiftUI

struct MarkDisplay: View {
    
    @State var mark: Mark
    
    var body: some View {
        
        HStack {
        
            Toggle(isOn: $mark.received, label: { Text("") })
            
            if mark.received {
                Text("\(mark.returnUnwrappedValue())")
            } else {
                Text("\(mark.returnUnwrappedExcuse())")
            }
        
        }
        
    }
}

struct MarkDisplay_Previews: PreviewProvider {
    static var previews: some View {
        MarkDisplay(mark: Mark.example)
    }
}
