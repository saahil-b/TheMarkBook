//
//  DivisionAnalysisView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 14/12/2021.
//

import Charts
import SwiftUI

struct DivisionAnalysisView: View {
    
    let analysis: DivisionAnalyser
    
    @State var percentageMarkChartEntries: [BarChartDataEntry] = []
    @State var topStudents: [String] = []
    @State var topTopics: [String] = []
    @State var topTerms: [String] = []
    
    let maxDisplayLength = 4
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Label("Back", systemImage: "chevron.left")
            }
            
            Text("Division Analysis")
                .font(.largeTitle)
            
            HStack {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text(analysis.division.name)
                        
                        Text("Handed in: \(analysis.handedInValues()[0])/\(analysis.division.returnAllAssignments().count)")
                        Text("Not in:         \(analysis.handedInValues()[1])/\(analysis.division.returnAllAssignments().count)")
                    }
                    
                    VStack(alignment: .center) {
                        Section(header: Text("Average % mark over time").font(.title)) {
                            NumericalBarChartView(entries: percentageMarkChartEntries, dataSetLabel: "average percentage mark over time", isPercent: true, chartColour: .systemBlue)
                        }
                    }
                }

                VStack {
                    Section(header: Text("Top students").font(.title)) {
                        List {
                            ForEach(Array(0..<topStudents.count), id: \.self) { i in
                                Text("\(i+1). \(topStudents[i])")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Section(header: Text("Top topics").font(.title)) {
                        List {
                            ForEach(Array(0..<topTopics.count), id: \.self) { i in
                                Text("\(i+1). \(topTopics[i])")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Section(header: Text("Top terms").font(.title)) {
                        List {
                            ForEach(Array(0..<topTerms.count), id: \.self) { i in
                                Text("\(i+1). \(topTerms[i])")
                            }
                        }
                    }
                }
                
            }
            
        }
        .padding()
        .onAppear(perform: { assignVariables() })
        
    }
    
    func assignVariables() {
        
        percentageMarkChartEntries = ChartDataConverter.SingleValueBarDataEntries(values: analysis.averagePercentageOverTime())
        
        topStudents = analysis.rankStudents()
        
        topTopics = analysis.bestPerformingTopics()
        
        topTerms = analysis.bestPerformingTerms()
        
        
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
