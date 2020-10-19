//
//  WelcomeVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 17/10/20.
//

import UIKit

class WelcomeVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var page1ImageView: UIImageView!
    @IBOutlet weak var page2ImageView: UIImageView!
    @IBOutlet weak var page3ImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    let filledImage = UIImage(named: "oval")
    let unFilledImage = UIImage(named: "oval_")
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let slides = createSlides()
        setupScrollView(slides)
    }
    
    func createSlides() ->[SlideView]{
        
        let slide1 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slide1.welcomeImage.image = UIImage(named: "illustrateOne")
        slide1.underImageLabel.text = "Track Your Waste"
        slide1.descriptionLabel.text = "Record each waste you’ve produced in daily basis based on it’s category to help you reach the next level of zero waste life"
        
        let slide2 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slide2.welcomeImage.image = UIImage(named: "illustrateTwo")
        slide2.underImageLabel.text = "Set Your Goals"
        slide2.descriptionLabel.text = "Set your daily waste target and finish weekly eco friendly-task to keep you on track in your zero waste life goals"
        
        let slide3 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slide3.welcomeImage.image = UIImage(named: "illustrateThree")
        slide3.underImageLabel.text = "Scan Your Waste"
        slide3.descriptionLabel.text = "Discover each type of waste to understand better the material’s of product you found in your daily life"
        
        return [slide1, slide2, slide3]
    }
    
    func setupScrollView(_ slides: [SlideView]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 1.0)
        scrollView.isPagingEnabled = true
        
        for each in 0..<slides.count{
            slides[each].frame = CGRect(x: view.frame.width * CGFloat(each), y: 0, width: view.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slides[each])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/scrollView.frame.width)
        if pageIndex == 0{
            
        }else{
            
        }
        
        if pageIndex == 2{
            
            startButton.isHidden = false
        }else{
            
            startButton.isHidden = true
        }
        
        if pageIndex == 0{
            selectedIndex = 0
            page1ImageView.image = filledImage
            
            page2ImageView.image = unFilledImage
            page3ImageView.image = unFilledImage
        }else if pageIndex == 1{
            selectedIndex = 1
            page2ImageView.image = filledImage
            
            page1ImageView.image = unFilledImage
            page3ImageView.image = unFilledImage
        }else if pageIndex == 2{
            selectedIndex = 2
            page3ImageView.image = filledImage
            
            page1ImageView.image = unFilledImage
            page2ImageView.image = unFilledImage
        }else if pageIndex == 3{
            selectedIndex = 3
            
            page1ImageView.image = unFilledImage
            page2ImageView.image = unFilledImage
            page3ImageView.image = unFilledImage
        }
    }
    
    @IBAction func startTapped(_ sender: UIButton){
        
    }
    
}
