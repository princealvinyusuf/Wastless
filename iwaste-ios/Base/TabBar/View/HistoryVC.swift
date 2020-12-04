//
//  HistoryVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 24/10/20.
//

import UIKit
import BonsaiController

class HistoryVC: UIViewController {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var viewSummary: UIView!
    @IBOutlet weak var viewChart: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var lblChartDate: UILabel!
    
    @IBOutlet weak var nextDayButton: UIButton!
    @IBOutlet weak var prevDayButton: UIButton!
    
    @IBOutlet weak var lblDetailTotal: UILabel!
    @IBOutlet weak var lblDetailDay: UILabel!
    @IBOutlet weak var lblDetailDate: UILabel!
    
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblSummaryDetail: UILabel!
    
    var presenter: HistoryPresenter?
    var pickedDate = Date()
    var selectedHistory: String = "daily"

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HistoryPresenter()
        updateDate(type: selectedHistory)
        
        viewSummary.layer.cornerRadius = 15
        viewChart.layer.cornerRadius = 15
        viewDetail.layer.cornerRadius = 11
        
        viewSummary.layer.shadowColor = UIColor.black.cgColor
        viewChart.layer.shadowColor = UIColor.black.cgColor
        
        viewSummary.layer.shadowRadius = 5
        viewChart.layer.shadowRadius = 5
        
        viewSummary.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewChart.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        viewSummary.layer.shadowOpacity = 0.3
        viewChart.layer.shadowOpacity = 0.3
        
        //        presenter?.getTrashData(date: "01/11/2020"){(totalTrash, totalTargetCategory) in
        //            self.setDataChart(countWaste: totalTrash, targetWaste: totalTargetCategory)
        //        }
        //        setupChart()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(detailPressed))
        viewDetail.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
        updateDate(type: selectedHistory)
    }
    
    @objc func detailPressed() {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let detailHistoryVC = storyboard.instantiateViewController(identifier: "DetailHistoryVC") as! DetailHistoryVC
        detailHistoryVC.transitioningDelegate = self
        detailHistoryVC.modalPresentationStyle = .custom
        detailHistoryVC.pickedDate = pickedDate
        detailHistoryVC.selectedHistory = selectedHistory
        
        present(detailHistoryVC, animated: true, completion: nil)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            selectedHistory = "daily"
            updateDate(type: selectedHistory)
        }else if sender.selectedSegmentIndex == 1 {
            selectedHistory = "weekly"
            updateDate(type: selectedHistory)
        }
        else if sender.selectedSegmentIndex == 2 {
            selectedHistory = "monthly"
            updateDate(type: selectedHistory)
        }
    }
    func setupChart() {
        barChart.delegate = self
        barChart.doubleTapToZoomEnabled = false
        view.addSubview(barChart)
        
        barChart.backgroundColor = .clear
        barChart.isUserInteractionEnabled = false
        
        // Grid
        barChart.rightAxis.enabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelTextColor = UIColor.label
        barChart.leftAxis.labelTextColor = UIColor.label
        
        // Legend
        barChart.legend.horizontalAlignment = .left
        barChart.legend.enabled = true
        barChart.legend.font = .systemFont(ofSize: 14)
        barChart.legend.textColor = UIColor.label
        
        // Label
        barChart.leftAxis.labelFont = .systemFont(ofSize: 14)
        barChart.xAxis.labelFont = .systemFont(ofSize: 14)
        barChart.leftAxis.axisMinimum = 0
        
        // Add some constraint
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.topAnchor.constraint(equalTo: lblChartDate.bottomAnchor, constant: 8).isActive = true
        barChart.bottomAnchor.constraint(equalTo: viewChart.bottomAnchor, constant: -16).isActive = true
        barChart.leadingAnchor.constraint(equalTo: viewChart.leadingAnchor, constant: 16).isActive = true
        barChart.trailingAnchor.constraint(equalTo: viewChart.trailingAnchor, constant: -16).isActive = true
    }
    @IBAction func nextDayBtnPressed(_ sender: Any) {
        if selectedHistory == "daily"{
            pickedDate = Calendar.current.date(byAdding: .day , value: 1, to: pickedDate)!
            updateDate(type: selectedHistory)
        }else if selectedHistory == "weekly"{
            pickedDate = Calendar.current.date(byAdding: .day , value: 7, to: pickedDate)!
            updateDate(type: selectedHistory)
            
        }
        else if selectedHistory == "monthly"{
            pickedDate = Calendar.current.date(byAdding: .month , value: 1, to: pickedDate)!
            updateDate(type: selectedHistory)
        }
    }
    @IBAction func prevDayButton(_ sender: Any) {
        if selectedHistory == "daily"{
            pickedDate = Calendar.current.date(byAdding: .day , value: -1, to: pickedDate)!
            updateDate(type: selectedHistory)
        }else if selectedHistory == "weekly"{
            pickedDate = Calendar.current.date(byAdding: .day , value: -7, to: pickedDate)!
            updateDate(type: selectedHistory)
        }
        else if selectedHistory == "monthly"{
            pickedDate = Calendar.current.date(byAdding: .month , value: -1, to: pickedDate)!
            updateDate(type: selectedHistory)
        }
    }
    
    func updateDate(type:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "EEEE"
        
        let dateFormatter4 = DateFormatter()
        dateFormatter4.dateFormat = "d MMMM yyyy"
        
        let dateFormatter5 = DateFormatter()
        dateFormatter5.dateFormat = "MMMM, yyyy"
        
        let dateFormatter6 = DateFormatter()
        dateFormatter6.dateFormat = "MMMM"
        
        let dateFormatter7 = DateFormatter()
        dateFormatter7.dateFormat = "yyyy"
        
        let date = dateFormatter2.string(from: pickedDate)
        
        switch type{
        case "daily":
            presenter?.getTotalWasteDaily(date: date){(totalTrash, totalTarget, total) in
                self.setDataChart(countWaste: totalTrash, targetWaste: totalTarget, selectedHistory: self.selectedHistory)
                self.lblDetailTotal.text = String(total)
                
                //Function to show Summary
                let totalData = totalTrash.reduce(0, +)
                if totalData == 0{
                    self.lblSummaryDetail.text = dailySummary[5]
                }else{
                    let highestTrashCount = totalTrash.max()
                    let indexofTrash = totalTrash.firstIndex(of: highestTrashCount!)
                    self.lblSummaryDetail.text = dailySummary[indexofTrash!]
                    print(totalTrash)
                }
            }
            lblChartDate.text = dateFormatter.string(from: pickedDate)
            lblDetailDay.text = dateFormatter3.string(from: pickedDate)
            lblDetailDate.text = dateFormatter4.string(from: pickedDate)
            lblSummary.text = "Daily Summary"
            
        case "monthly":
            presenter?.getTotalWasteMonthly2(date:pickedDate){(totalTrash, totalTarget, total, trashSummary) in
                self.setDataChart(countWaste: totalTrash, targetWaste: totalTarget, selectedHistory: self.selectedHistory)
                self.lblDetailTotal.text = String(total)
                
                //Function to show Summary
                let totalData = trashSummary.reduce(0, +)
                if totalData == 0{
                    self.lblSummaryDetail.text = monthlySummary[5]
                }else{
                    let highestTrashCount = trashSummary.max()
                    let indexofTrash = trashSummary.firstIndex(of: highestTrashCount!)
                    self.lblSummaryDetail.text = monthlySummary[indexofTrash!]
                    print(trashSummary)
                }
            }
            lblChartDate.text = dateFormatter5.string(from: pickedDate)
            lblDetailDay.text = dateFormatter6.string(from: pickedDate)
            lblDetailDate.text = dateFormatter7.string(from: pickedDate)
            lblSummary.text = "Monthly Summary"

        case "weekly":
            getWeeklyDate(date: pickedDate){(startDate, endDate, dayArray) in
                self.lblChartDate.text = ("\(startDate) - \(endDate)")
                self.lblDetailDate.text = ("\(startDate) - \(endDate)")
                self.lblDetailDay.text = "This Week"
                self.lblSummary.text = "Weekly Summary"
                
                self.presenter?.getTotalWasteWeekly(date: dayArray){(totalTrash, totalTarget, total, trashSummary) in
                    self.setDataChart(countWaste: totalTrash, targetWaste: totalTarget, selectedHistory: self.selectedHistory)
                    self.lblDetailTotal.text = String(total)
                    
                    //Function to show Summary
                    let totalData = trashSummary.reduce(0, +)
                    if totalData == 0{
                        self.lblSummaryDetail.text = weeklySummary[5]
                    }else{
                        let highestTrashCount = trashSummary.max()
                        let indexofTrash = trashSummary.firstIndex(of: highestTrashCount!)
                        self.lblSummaryDetail.text = weeklySummary[indexofTrash!]
                        print(trashSummary)
                    }
                }
            }
        default:
            print("Default")
        }
        
        setupChart()
        
    }
    
    func getWeeklyDate(date : Date, completion: @escaping (_ startDate: String, _ endDate: String, _ dateArray: [Date]) ->()){
        //THIS FUNCTION IS TO GET DATE IN A WEEK
        let dateInWeek = date
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: dateInWeek) }
        
        let dateFormatterStart = DateFormatter()
        dateFormatterStart.dateFormat = "MMM d"
        
        let dateFormatterEnd = DateFormatter()
        dateFormatterEnd.dateFormat = "MMM d"
        
        let startDate = dateFormatterStart.string(from: days[0])
        let endDate = dateFormatterStart.string(from: days[6])
        completion(startDate, endDate, days)
    }
}

extension HistoryVC: UIViewControllerTransitioningDelegate, BonsaiControllerDelegate {
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 2.5), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 1.665))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.7), presentedViewController: presented, delegate: self)
    }
}


