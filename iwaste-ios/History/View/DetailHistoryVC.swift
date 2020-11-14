//
//  DetailHistoryVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 24/10/20.
//

import UIKit

class DetailHistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgPlastic: UIImageView!
    @IBOutlet weak var imgGlass: UIImageView!
    @IBOutlet weak var imgPaper: UIImageView!
    @IBOutlet weak var imgMetal: UIImageView!
    @IBOutlet weak var imgOrganic: UIImageView!
    

    @IBOutlet weak var lblPlasticCount: UILabel!
    @IBOutlet weak var lblGlassCount: UILabel!
    @IBOutlet weak var lblPaperCount: UILabel!
    @IBOutlet weak var lblMetalCount: UILabel!
    @IBOutlet weak var lblOrganicCount: UILabel!
    
    
    @IBOutlet weak var txtTitle: UINavigationItem!
    
    
    var pickedDate = Date()
    var selectedHistory = "daily"
    var presenter: DetailHistoryPresenter?
    var listWasteHistory = [WasteHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailHistoryPresenter()
        updateUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailHistoryCell", bundle: self.nibBundle), forCellReuseIdentifier: "detailHistoryCell")
        
        imgPlastic.image = UIImage(named: "trashbinplastic")
        imgGlass.image = UIImage(named: "trashbinglass")
        imgPaper.image = UIImage(named: "trashbinpaper")
        imgMetal.image = UIImage(named: "trashbinmetal")
        imgOrganic.image = UIImage(named: "trashbinorganic")
//        
//        presenter?.dateChecker(date: pickedDate){(date) in
//            self.txtTitle.title = date
//        }
        
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        presenter?.dateChecker(date: pickedDate, type: selectedHistory){(date, dateCD)in
            if self.selectedHistory == "daily"{
                print("daily")
                print(date)
                self.txtTitle.title = date
                self.presenter?.loadTrashData(date: dateCD){(trashCount, listWaste)in
                    self.lblPlasticCount.text = String(trashCount[0])
                    self.lblGlassCount.text = String(trashCount[1])
                    self.lblPaperCount.text = String(trashCount[2])
                    self.lblMetalCount.text = String(trashCount[3])
                    self.lblOrganicCount.text = String(trashCount[4])
                    self.listWasteHistory = listWaste
                    self.tableView.reloadData()
                     
                }
            }
            else if self.selectedHistory == "monthly"{
                print("monthly")
                print(date)
                self.txtTitle.title = date
                self.presenter?.loadTrashDataMonthly(date: self.pickedDate){(trashCount, listWaste)in
                    self.lblPlasticCount.text = String(trashCount[0])
                    self.lblGlassCount.text = String(trashCount[1])
                    self.lblPaperCount.text = String(trashCount[2])
                    self.lblMetalCount.text = String(trashCount[3])
                    self.lblOrganicCount.text = String(trashCount[4])
                    self.listWasteHistory = listWaste
                    self.tableView.reloadData()
                }
            }
            
            else if self.selectedHistory == "weekly"{
                self.getWeeklyDate(date: self.pickedDate){(startDate, endDate, dateArray) in
                    self.txtTitle.title = ("\(startDate) - \(endDate)")
                    self.presenter?.loadTrashDataWeekly(date: dateArray){(trashCount, listWaste)in
                        self.lblPlasticCount.text = String(trashCount[0])
                        self.lblGlassCount.text = String(trashCount[1])
                        self.lblPaperCount.text = String(trashCount[2])
                        self.lblMetalCount.text = String(trashCount[3])
                        self.lblOrganicCount.text = String(trashCount[4])
                        self.listWasteHistory = listWaste
                        self.tableView.reloadData()
                    }
                    
                }

            }
            
        }
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

extension DetailHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWasteHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailHistoryCell") as? DetailHistoryCell else {return UITableViewCell()}
        cell.configureCell(listHistory: listWasteHistory[indexPath.row])
        return cell
    }
    
    
}
