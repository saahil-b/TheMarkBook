//
//  DivisionItem.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 16/09/2021.
//

import SwiftUI

struct DivisionItem: View {
    
    let division: Division
    
    var body: some View {
        HStack {
        Image(systemName: "\(3).circle")
        //division.students.count
        Text("\(division.name)")
        }
    }
}

struct DivisionItem_Previews: PreviewProvider {
    static var previews: some View {
        DivisionItem(division: Division.currentExamples[0])
    }
}
