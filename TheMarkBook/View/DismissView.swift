//
//  DismissView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 14/12/2021.
//

import SwiftUI

struct DismissView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("")
            .onAppear(perform: {
                presentationMode.wrappedValue.dismiss()
            })
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
