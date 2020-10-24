//
//  ChartService.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 24/10/20.
//

import UIKit
import Charts

let barChart = BarChartView()

extension HistoryVC: ChartViewDelegate {
    
    func setDataChart() {
        let countWaste: [Int] = [17, 43, 9, 26, 55]
        let targetWaste: [Int] = [20, 24, 28, 32, 66]
        
        var countWasteEntry = [BarChartDataEntry]()
        var targetWasteEntry = [BarChartDataEntry]()
        
        for x in 0..<countWaste.count {
            let countWasteData = BarChartDataEntry(x: Double(x), y: Double(countWaste[x]))
            countWasteEntry.append(countWasteData)
            
            let targetWasteData = BarChartDataEntry(x: Double(x), y: Double(targetWaste[x]))
            targetWasteEntry.append(targetWasteData)
        }
        
        let countWasteDataSet = BarChartDataSet(entries: countWasteEntry, label: "Your Progress")
        countWasteDataSet.drawValuesEnabled = false
        countWasteDataSet.setColor(K.Color.primarySoft)
        
        let targetWasteDataSet = BarChartDataSet(entries: targetWasteEntry, label: "Your Target")
        targetWasteDataSet.drawValuesEnabled = false
        targetWasteDataSet.setColor(K.Color.primaryColor)
        
        let groupChartData = BarChartData(dataSets: [countWasteDataSet, targetWasteDataSet])
        groupChartData.notifyDataChanged()
        
        let groupSpace = 0.2
        let barSpace = 0.05
        let barWidth = 0.35
        
        let groupSpaces = groupChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Plastic", "Metal", "Paper", "Glass", "Organic"])
        barChart.xAxis.axisMinimum = 0
        barChart.xAxis.axisMaximum = groupSpaces * 5 / 2
        barChart.xAxis.centerAxisLabelsEnabled = true
        barChart.xAxis.granularity = 1
        barChart.xAxis.drawGridLinesEnabled = false
        
        groupChartData.barWidth = barWidth
        groupChartData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        groupChartData.notifyDataChanged()
        barChart.animate(yAxisDuration: 1, easingOption: .easeInCubic)
        barChart.data = groupChartData
    }
}
