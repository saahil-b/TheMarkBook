//
//  MainView.swift
//  TheMarkBook
//
//  Created by Bahadur, Saahil (PAH) on 13/09/2021.
//

import SwiftUI

struct MainView: View {
    
    // allows access to stateController
    @EnvironmentObject var state: StateController
    
    @EnvironmentObject var cc: CustomColour
    
    @State var coverVisible = false
    @State var coverType = ""
    
    @State var searchText = ""
    
    @State var refresh = false
    
//    init() {
//        UITableView.appearance().backgroundColor = cc.uiBack
////        UITableViewCell.appearance().backgroundColor = UIColor.red
//    }
    
    var body: some View {
                
        VStack {
            
//            cc.back1.edgesIgnoringSafeArea(.all)
            
            NavigationView {
                
                ZStack {

                    cc.back1.edgesIgnoringSafeArea(.all)
                
                    VStack {
                
                    // lists division items
                        
                    List {
                        
                        HStack{
                            Spacer()
                            
                            Text("Classes")
                                .font(.largeTitle)
                                .foregroundColor(cc.title)
                            
                            Spacer()
                        }

                        
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

                        if refresh {}
                        
                                                
                        // accesses each division in currentDivisions
                        ForEach(state.currentDivisions.filter({ searchFilter(division: $0) }), id: \.self.id) { division in
                            NavigationLink(destination: DivisionView(division: division, updateDivisionName: updateDivisionName )) {
                                // separate view class
                                HStack {
                                    Image(systemName: "\(division.students.count).circle")
                                    //division.students.count
                                    Text("\(division.name)")

                                    Spacer()
                                                
                                }.foregroundColor(cc.body)
                            }
                        } // defines functions for actions performed on list
                        .onMove(perform: moveCurrentDivision)
                        .onDelete(perform: archiveCurrentDivision)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            // edit button
                            EditButton()
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            // button for adding new division
                            Button(action: { addNewDivision() }, label: {
                                Image(systemName: "plus")
                            })
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            // button to navigate to archive
                            Button(action: {
                                coverType = "archive"
                                refreshView()
                                coverVisible = true
                            }) {
                                if state.archivedDivisions.count == 0 {
                                    Image(systemName: "trash")
                                } else {
                                    Image(systemName: "trash.fill")
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            // button to navigate to colour view
                            Button(action: {
                                coverType = "colour"
                                refreshView()
                                coverVisible = true
                            }) {
//                                Image(systemName: "circle.hexagongrid")
                                Image(systemName: "smallcircle.circle")
                            }
                        }
                        
                    }
                
                }
                    
                }
                
                cc.back1.edgesIgnoringSafeArea(.all)
                
            }
            .fullScreenCover(isPresented: $coverVisible, content: {
                switch coverType {
                
                case "archive":
                    ArchiveView()
                    
                case "colour":
                    ColourView()
                
                default:
                    DismissView()
                    
                }
                
            })

        }
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = .clear
        })
        .accentColor(cc.accent)
        .foregroundColor(cc.body)
    }
    
    // function called onMove()
    func moveCurrentDivision(from source: IndexSet, to destination: Int) {
        // calls move function defined in state
        state.moveCurrentDivision(fromOffsets: source, toOffset: destination)
        localSave()
    }
    
    // function called onDelete
    func archiveCurrentDivision(at offsets: IndexSet) {
        for i in offsets {
            // calls archive function defined in state
            state.archiveDivision(index: i)
        }
        localSave()
    }
    
    func addNewDivision() {
        
        let div = Division(name: "New class", id: state.divisionIDManager.generateNewID())
        
        div.addStudent(name: "New student", dateOfBirth: Date(), contactInfo: "example@email.com")
        div.addTerm()
        div.addAssignment(assignment: Assignment(name: "New assignment", date: Date(), topic: "example", id: div.assignmentIDManager.generateNewID()), termIndex: 0)
        
        state.addToCurrentDivisions(division: div)
        refresh.toggle()
        localSave()
    }
    
    func updateDivisionName(name: String) {
//        state.currentDivisions = state.currentDivisions
        refresh.toggle()
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
    
    func localSave() {
        state.saveToFile()
    }
    
    func refreshView() {
        refresh.toggle()
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StateController.example)
            .environmentObject(CustomColour.initial)
    }
}
