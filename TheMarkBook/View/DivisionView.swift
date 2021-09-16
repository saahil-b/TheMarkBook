//
//  DivisionView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionView: View {
    
    let division: Division
    
    var body: some View {
        Text("hi")
    }
        
}

struct DivisionView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionView(division: Division.currentExamples[0])
    }
}
