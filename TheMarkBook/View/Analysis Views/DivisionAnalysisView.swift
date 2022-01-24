//
//  DivisionAnalysisView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 14/12/2021.
//

import Charts
import SwiftUI

struct DivisionAnalysisView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    let analysis: DivisionAnalyser
    
    @State var percentageMarkChartEntries: [BarChartDataEntry] = []
    @State var topStudents: [String] = []
    @State var topTopics: [String] = []
    @State var topTerms: [String] = []
    
    @State var totalHandIns: Int = 0
    
    let maxDisplayLength = 4
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedIndex: Int? = nil

    @State var labels: [String] = []
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack(alignment: .leading) {
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Label("Back", systemImage: "chevron.left")
            }.foregroundColor(cc.accent)
            
            Text("Division Analysis")
                .font(.largeTitle)
                .foregroundColor(cc.title)
            
            HStack {
                VStack(alignment: .leading) {
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
                            NumericalBarChartView(entries: percentageMarkChartEntries, dataSetLabel: "average percentage mark over time", isPercent: true, chartColour: UIColor(cc.accent), selectedIndex: $selectedIndex)
                        }
                        
                        if let x = selectedIndex {
                            Text("Selected: \(labels[x])")
                        } else {
                            Text("Selected: none")
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
                    
                    Spacer()
                    
                    Section(header: Text("Top terms").font(.title).foregroundColor(cc.title)) {
                        List {
                            ForEach(Array(0..<topTerms.count), id: \.self) { i in
                                Text("\(i+1). \(topTerms[i])")
                            }
                            .listRowBackground(cc.back1)
                        }
                    }
                }
                
            }
            
        }
        .padding()
        .onAppear(perform: { assignVariables() })
            
        }
        
    }
    
    func assignVariables() {
        
        percentageMarkChartEntries = ChartDataConverter.SingleValueBarDataEntries(values: analysis.averagePercentageOverTime())
        
        topStudents = analysis.rankStudents()
        
        topTopics = analysis.bestPerformingTopics()
        
        topTerms = analysis.bestPerformingTerms()
        
        totalHandIns = Int(Double(analysis.division.returnAllAssignments().count) * Double(analysis.division.students.count))
        
        for assignment in analysis.returnOrderedAssignments() {
            labels.append(assignment.name)
        }
        
        
    }
    
//    func setLengthList(array: [String], length: Int) -> [String] {
//
//        // copies input array
//        var result = array
//        // checks if array length is greater than desired
//        if result.count > length {
//            // sets array to subarray pf correct length
//            result = Array(topStudents[0..<length])
//        } else {
//            // handles case where array is smaller than desired length
//            while result.count < length{
//                result.append("")
//            }
//        }
//
//        return result
//
//    }
    
}

struct DivisionAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionAnalysisView(analysis: DivisionAnalyser(division: Division.currentExamples[0]) )
    }
}
