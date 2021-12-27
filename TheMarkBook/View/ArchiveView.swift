//
//  ArchiveView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 17/09/2021.
//

import SwiftUI

struct ArchiveView: View {
    
    @EnvironmentObject var state: StateController
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchText = ""
    
//        init() {
//            UITableView.appearance().backgroundColor = UIColor.yellow
////            UITableViewCell.appearance().backgroundColor = UIColor.red
//        }
    
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
            
            if state.archivedDivisions.count > 0 {
                // archive title
                Text("Bin")
                    .font(.largeTitle)
                    .foregroundColor(cc.title)
                
                // search bar
                HStack {
                    TextField("Search classes", text: $searchText)
                        .padding(.leading, 24)
                }
                .padding()
                .background(cc.searchBack)
                .cornerRadius(6)
                .padding(.horizontal)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Spacer()
                        
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }){
                                Image(systemName: "xmark.circle.fill")
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .foregroundColor(cc.searchOverlay)
                )
                
                
            } else {
                // text displayed when bin is empty
                Text("Bin is empty")
                    .font(.title)
                    .foregroundColor(cc.title)
            }
            
            // list of archived divisions
            List {
                ForEach(state.archivedDivisions.filter({ searchFilter(division: $0) }), id: \.self.id) { division in
                    ArchivedDivisionItem(division: division, recoverDivision: recoverDivision, deleteDivision: deleteDivision)
                }
                .listRowBackground(cc.back1.edgesIgnoringSafeArea(.all))
            }

        }.padding()
        
    }
    }
    
    func searchFilter(division: Division) -> Bool {
        if searchText == "" || division.name == "" {
            return true
        } else {
            if division.name.contains(searchText) {
                return true
            }
        }
        return false
    }
    
    func recoverDivision(id: Int) {
        if let i = state.findDivisionIndexInArchive(id: id) {
            state.recoverDivision(index: i)
        }
        localSave()
    }
    
    func deleteDivision(id: Int) {
        if let i = state.findDivisionIndexInArchive(id: id) {
            state.deleteFromArchivedDivisions(index: i)
        }
        localSave()
    }
    
    func localSave() {
        state.saveToFile()
    }
    
    
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
            .environmentObject(StateController.example)
    }
}
