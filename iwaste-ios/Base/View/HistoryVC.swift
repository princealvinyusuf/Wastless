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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSummary.layer.cornerRadius = 15
        viewChart.layer.cornerRadius = 15
        viewDetail.layer.cornerRadius = 11
        
        viewSummary.backgroundColor = UIColor.darkGray
        viewChart.backgroundColor = UIColor.darkGray
        
//        viewSummary.layer.shadowColor = UIColor.white.cgColor
//        viewChart.layer.shadowColor = UIColor.white.cgColor
//        
//        viewSummary.layer.shadowRadius = 5
//        viewChart.layer.shadowRadius = 5
//        
//        viewSummary.layer.shadowOffset = CGSize(width: 0, height: 2)
//        viewChart.layer.shadowOffset = CGSize(width: 0, height: 2)
//        
//        viewSummary.layer.shadowOpacity = 0.04
//        viewChart.layer.shadowOpacity = 0.04
        
        setupChart()
        setDataChart()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(detailPressed))
        viewDetail.addGestureRecognizer(tap)
    }
    
    @objc func detailPressed() {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let detailHistoryVC = storyboard.instantiateViewController(identifier: "DetailHistoryVC") as! DetailHistoryVC
        detailHistoryVC.transitioningDelegate = self
        detailHistoryVC.modalPresentationStyle = .custom
        
        present(detailHistoryVC, animated: true, completion: nil)
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
}

extension HistoryVC: UIViewControllerTransitioningDelegate, BonsaiControllerDelegate {
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 2.5), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.7), presentedViewController: presented, delegate: self)
    }
}
