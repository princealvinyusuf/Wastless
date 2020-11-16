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
        
        
        //If Daily Or Monthly
        if selectedHistory == "daily" {
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(
                values: [
                    "Plastics",
                    "Glass",
                    "Papers",
                    "Metals",
                    "Organic"])
            
            barChart.xAxis.axisMinimum = 0
            barChart.xAxis.axisMaximum = groupSpaces * 5 / 2
        }else if selectedHistory == "monthly"{
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(
                values: [
                    "Week 1",
                    "Week 2",
                    "Week 3",
                    "Week 4"])
            
            barChart.xAxis.axisMinimum = 0
            barChart.xAxis.axisMaximum = groupSpaces * 4 / 2
        }else if selectedHistory == "weekly"{
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: Calendar.current.shortWeekdaySymbols)
            barChart.xAxis.axisMinimum = 0
            barChart.xAxis.axisMaximum = groupSpaces * 7 / 2
            
        }
        
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
