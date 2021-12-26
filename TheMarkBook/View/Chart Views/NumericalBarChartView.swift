//
//  NumericalBarChartView.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 13/12/2021.
//

import Charts
import SwiftUI

struct NumericalBarChartView: UIViewRepresentable {
    
    let entries: [BarChartDataEntry]
    let dataSetLabel: String
    let isPercent: Bool
    let chartColour: UIColor
    
    func makeUIView(context: Context) -> BarChartView {
        return BarChartView()
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        
        // defines data set for chart
        let dataSet = BarChartDataSet(entries: entries)
        
        // sets data label
        dataSet.label = nil
        
        // text displayed if no data passed
        uiView.noDataText = "No data"
        
        // displays the chart
        uiView.data = BarChartData(dataSet: dataSet)
        
        // changes bar colour
        dataSet.colors = [chartColour]
        
        // used for formatting values displayed
        let formatter = NumberFormatter()
        if isPercent {
            // changes number to percentage
            formatter.numberStyle = .percent
        }
        // ensures maximum no. decimal places is 1
        formatter.maximumFractionDigits = 1
        
        // formats data values
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
    }
    
    
}

struct NumericalBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        NumericalBarChartView(entries: ChartDataConverter.SingleValueBarDataEntries(values: [24.5, 45.6, 37.4, 71.6345] ),
                              dataSetLabel: "data", isPercent: false, chartColour: .red)
    }
}


