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
    
    func setDataChart(countWaste: [Int], targetWaste: [Int], selectedHistory: String) {
        //let countWaste: [Int] = [17, 43, 9, 26, 55]
        //let targetWaste: [Int] = [20, 24, 28, 32, 66]
        
        var countWasteEntry = [BarChartDataEntry]()
        var targetWasteEntry = [BarChartDataEntry]()
        
        //If Data Empty
        if countWaste.count == 0 || targetWaste.count == 0{
            for x in 0...4 {
                let countWasteData = BarChartDataEntry(x: Double(x), y: 0)
                countWasteEntry.append(countWasteData)
                
                let targetWasteData = BarChartDataEntry(x: Double(x), y: 0)
                targetWasteEntry.append(targetWasteData)
            }
        }
        //If Data Not Empty
        else{
            for x in 0..<countWaste.count {
                let countWasteData = BarChartDataEntry(x: Double(x), y: Double(countWaste[x]))
                countWasteEntry.append(countWasteData)
                
                let targetWasteData = BarChartDataEntry(x: Double(x), y: Double(targetWaste[x]))
                targetWasteEntry.append(targetWasteData)
            }
        }
        
        
        let countWasteDataSet = BarChartDataSet(entries: countWasteEntry, label: NSLocalizedString("chart_yourprogress", comment: "Your Progress"))
        countWasteDataSet.drawValuesEnabled = false
        countWasteDataSet.setColor(K.Color.primarySoft)
        
        let targetWasteDataSet = BarChartDataSet(entries: targetWasteEntry, label: NSLocalizedString("chart_yourtarget", comment: "Your Target"))
        targetWasteDataSet.drawValuesEnabled = false
        targetWasteDataSet.setColor(K.Color.primaryColor)
        
        let groupChartData = BarChartData(dataSets: [countWasteDataSet, targetWasteDataSet])
        groupChartData.notifyDataChanged()
        
        let groupSpace = 0.2
        let barSpace = 0.05
        let barWidth = 0.35
        
        let groupSpaces = groupChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        
        
        //If Daily Or Monthly
        if selectedHistory == "daily" {
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: [NSLocalizedString("axis_plastics", comment: "Plastics"), NSLocalizedString("axis_glass", comment: "Glass"), NSLocalizedString("axis_papers", comment: "Papers"), NSLocalizedString("axis_metals", comment: "Metals"), NSLocalizedString("axis_organic", comment: "Organic")])
        }else if selectedHistory == "monthly"{
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: [NSLocalizedString("axis_week1", comment: "Week 1"), NSLocalizedString("axis_week2", comment: "Week 2"), NSLocalizedString("axis_week3", comment: "Week 3"), NSLocalizedString("axis_week4", comment: "Week 4")])
        }
        
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
