//
//  DismissView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 14/12/2021.
//

import SwiftUI

struct DismissView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        cc.back1.edgesIgnoringSafeArea(.all)
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
