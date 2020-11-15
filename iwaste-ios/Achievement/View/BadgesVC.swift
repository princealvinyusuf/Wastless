//
//  BadgesVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit
import BonsaiController

class BadgesVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var collectionBadges: UICollectionView!
    
    let arrayBadges = Badges.createBadges()
    var udService = UserDefaultService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionBadges.delegate = self
        collectionBadges.dataSource = self
        collectionBadges.register(UINib(nibName: "BadgeViewCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "badgeViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 170, height: 180)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        collectionBadges.collectionViewLayout = flowLayout
        
    }
    
}

extension BadgesVC: BonsaiControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
        
    }
}

extension BadgesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayBadges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "badgeViewCell", for: indexPath) as? BadgeViewCell else {return UICollectionViewCell()}
        let badge = arrayBadges[indexPath.row]
        cell.configureCell(badge: badge)
        
        if !BadgeService.isContain(num: indexPath.row) {
            cell.imgBadge.image = UIImage(named: "blankBadges")!
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let detailBadgesVC = storyboard.instantiateViewController(identifier: "DetailBadgesVC") as! DetailBadgesVC
        detailBadgesVC.pos = indexPath.row
        detailBadgesVC.badge = arrayBadges[indexPath.row]
        detailBadgesVC.transitioningDelegate = self
        detailBadgesVC.modalPresentationStyle = .custom
        self.present(detailBadgesVC, animated: true, completion: nil)
    }
}
