//
//  StudentAnalysisView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 13/12/2021.
//

import Charts
import SwiftUI

struct StudentAnalysisView: View {
    
    @EnvironmentObject var cc: CustomColour
    
    @Environment(\.presentationMode) var presentationMode

    let analysis: StudentAnalyser
    
    @State var percentageMarkChartEntries: [BarChartDataEntry] = []
    @State var comparativeMarkChartEntries: [BarChartDataEntry] = []
    
    var body: some View {
        
        ZStack {
            
            cc.back1.edgesIgnoringSafeArea(.all)
        
        VStack(alignment: .leading) {
            
            Button(action: {presentationMode.wrappedValue.dismiss() }) {
                Label("Back", systemImage: "chevron.left")
            }
            .foregroundColor(cc.accent)
            
            Text("Student Analysis")
                .font(.largeTitle)
                .foregroundColor(cc.title)
            
            Text(analysis.student.name)
            Text(analysis.division.name)
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                VStack {
                    if percentageMarkChartEntries.count > 0 {
                        Section(header: Text("% mark per assignment").font(.title).foregroundColor(cc.title)) {
                            NumericalBarChartView(entries: percentageMarkChartEntries, dataSetLabel: "percentage mark", isPercent: true, chartColour: UIColor(cc.accent) )
                        }
                        
                    }  else {
                        Text("% mark per assignment")
                            .font(.title)
                            .foregroundColor(cc.title)
                        Spacer()
                        Text("No mark data")
                        Spacer()
                    }

                    if comparativeMarkChartEntries.count > 0 {
                        Section(header: Text("% mark compared to average").font(.title).foregroundColor(cc.title)) {
                            NumericalBarChartView(entries: comparativeMarkChartEntries, dataSetLabel: "percentage mark compared to mean", isPercent: true, chartColour: UIColor(cc.accent) )
                        }
                        
                    } else {
                        Text("% mark compared to average")
                            .font(.title)
                            .foregroundColor(cc.title)
                        Spacer()
                        Text("No mark data")
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("Position:     \(analysis.studentPosition())")
                    Text("Best topic:  \(analysis.favouriteTopic())")
                    Text("Handed in:   \(analysis.handedInValues()[0])/\(analysis.student.marks.count)")
                    Text("Not in:           \(analysis.handedInValues()[1])/\(analysis.student.marks.count)")
                    
                }
                
                Spacer()
                
            }
            
        }
        .padding()
        .onAppear(perform: {
            prepareData()
        })
            
        }
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
