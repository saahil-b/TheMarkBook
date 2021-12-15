//
//  StudentAnalysisView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 13/12/2021.
//

import Charts
import SwiftUI

struct StudentAnalysisView: View {
    
    @Environment(\.presentationMode) var presentationMode

    let analysis: StudentAnalyser
    
    @State var percentageMarkChartEntries: [BarChartDataEntry] = []
    @State var comparativeMarkChartEntries: [BarChartDataEntry] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button(action: {presentationMode.wrappedValue.dismiss() }) {
                Label("Back", systemImage: "chevron.left")
            }
            
            Text("Student Analysis")
                .font(.largeTitle)
            
            Text(analysis.student.name)
            Text(analysis.division.name)
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                VStack {
                    if percentageMarkChartEntries.count > 0 {
                        Section(header: Text("% mark per assignment").font(.title)) {
                            NumericalBarChartView(entries: percentageMarkChartEntries, dataSetLabel: "percentage mark", isPercent: true, chartColour: .systemBlue)
                        }
                        
                    }  else {
                        Text("% mark per assignment").font(.title)
                        Spacer()
                        Text("No mark data")
                        Spacer()
                    }

                    if comparativeMarkChartEntries.count > 0 {
                        Section(header: Text("% mark compared to average").font(.title)) {
                            NumericalBarChartView(entries: comparativeMarkChartEntries, dataSetLabel: "percentage mark compared to mean", isPercent: true, chartColour: .systemBlue)
                        }
                        
                    } else {
                        Text("% mark compared to average").font(.title)
                        Spacer()
                        Text("No mark data")
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("position:     \(analysis.studentPosition())")
                    Text("best topic:  \(analysis.favouriteTopic())")
                    Text("handed in:   \(analysis.handedInValues()[0])/\(analysis.student.marks.count)")
                    Text("not in:           \(analysis.handedInValues()[1])/\(analysis.student.marks.count)")
                    
                }
                
                Spacer()
                
            }
            
        }
        .padding()
        .onAppear(perform: {
            prepareData()
        })
    }
    
    func prepareData() {
        
        percentageMarkChartEntries = ChartDataConverter.SingleValueBarDataEntries(values: analysis.percentageMarkOverTime())
        
        comparativeMarkChartEntries = ChartDataConverter.SingleValueBarDataEntries(values: analysis.percentageMarkComparedToAverage())
        
    }
    
}

struct StudentAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        StudentAnalysisView(analysis: StudentAnalyser(student: StateController.example.currentDivisions[0].students[0], division: StateController.example.currentDivisions[0]))
    }
}
