//
//  ColourView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 25/12/2021.
//

import SwiftUI

struct ColourView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                    Spacer()
                }
                .foregroundColor(cc.accent)
                
                Text("Colour scheme")
                    .font(.largeTitle)
                    .foregroundColor(cc.title)
                
                
                List {
                    ForEach(Array(cc.schemes.enumerated()), id: \.offset) { i, scheme in
                        
                        if cc.schemeIndex == i {
                                
                            Text(scheme)
                                .listRowBackground(cc.accent.edgesIgnoringSafeArea(.all))

                        } else {
                            
                            Button(action: {
                                cc.changeIndex(index: i)
                                cc.saveToFile()
                            }) {
                                Text(scheme)
                            }
                            .listRowBackground(cc.back1)
                        }
                        
                    } //.listRowBackground(cc.back1)
                    
                }
                
            }
            .padding()
            .foregroundColor(cc.body)
            
        }
        
    }
}

struct ColourView_Previews: PreviewProvider {
    static var previews: some View {
        ColourView()
            .environmentObject(CustomColour.initial)
    }
}
