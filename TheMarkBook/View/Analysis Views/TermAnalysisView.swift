//
//  TermAnalysisView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 15/12/2021.
//

import Charts
import SwiftUI

struct TermAnalysisView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let analysis: TermAnalyser
    
    @State var percentageMarkChartEntries: [BarChartDataEntry] = []
    @State var topStudents: [String] = []
    @State var topTopics: [String] = []
    
    @State var totalHandIns: Int = 0

    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack(alignment: .leading) {
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Label("Back", systemImage: "chevron.left")
            }
            .foregroundColor(cc.accent)
            
            Text("Term Analysis")
                .font(.largeTitle)
                .foregroundColor(cc.title)
            
            HStack {
                
                VStack(alignment: .leading) {
            
                    Text(analysis.term.name)
                    Text("ID: \(analysis.term.id)")
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Handed in:")
                            Text("Not in:")
                        }
                        
                        VStack(alignment: .trailing) {
                            Text("\(analysis.handedInValues()[0])")
                            Text("\(analysis.handedInValues()[1])")
                        }
                        
                        VStack(alignment: .leading) {
                            Text("/ \(totalHandIns)")
                            Text("/ \(totalHandIns)")
                        }
                    }
                    
                    VStack(alignment: .center) {
                        Section(header: Text("Average % mark over time").font(.title).foregroundColor(cc.title)) {
                            NumericalBarChartView(entries: percentageMarkChartEntries, dataSetLabel: "average percentage mark over time", isPercent: true, chartColour: UIColor(cc.accent))
                        }
                    }
                    
                }
                
                VStack {
                    
                    Section(header: Text("Top students").font(.title).foregroundColor(cc.title)) {
                        List {
                            ForEach(Array(0..<topStudents.count), id: \.self) { i in
                                Text("\(i+1). \(topStudents[i])")
                            }
                            .listRowBackground(cc.back1)
                        }
                    }
                    
                    Spacer()
                    
                    Section(header: Text("Top topics").font(.title).foregroundColor(cc.title)) {
                        List {
                            ForEach(Array(0..<topTopics.count), id: \.self) { i in
                                Text("\(i+1). \(topTopics[i])")
                            }
                            .listRowBackground(cc.back1)
                        }
                    }
                    
                    
                }
                
            }
            
        }
        .padding()
        .onAppear(perform: {
            assignVariables()
        })
        
        }
    }
    
    func assignVariables() {
        
        percentageMarkChartEntries = ChartDataConverter.SingleValueBarDataEntries(values: analysis.averagePercentageOverTime())
        
        topStudents = analysis.rankStudents()
        topTopics = analysis.bestPerformingTopics()
        
        totalHandIns = Int(Double(analysis.term.assignments.count) * Double(analysis.division.students.count))
        
        
    }
    
    
}

struct TermAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        TermAnalysisView(analysis: TermAnalyser(term: StateController.example.currentDivisions[0].terms[0], division: StateController.example.currentDivisions[0]))
    }
}
