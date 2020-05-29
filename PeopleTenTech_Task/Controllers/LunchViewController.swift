//
//  FirstViewController.swift
//  PeopleTenTech_Task
//
//  Created by Raghuram on 29/05/20.
//  Copyright © 2020 Raghuram. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {
    
    @IBOutlet weak var collView: UICollectionView!
    
    
    var viewModel = LunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
        addCustomFont()
    }
    
    
    func addCustomFont(){
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 17)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    
    func loadData() {
        viewModel.fetchJson { (res) in
            switch res {
            case .success(let lunch):
               
                DispatchQueue.main.async {
                    
                    self.collView.reloadData()
                }
                
            case .failure(let err):
                print(err, "Failed to fetch ")
                self.alertUser(msg: err.localizedDescription)
            }
        }
        
    }
    
    func alertUser(msg : String){
        
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (alert) in
            self.loadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        collView.collectionViewLayout.invalidateLayout()
    }
    
}


extension LunchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataModel?.restaurants.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let lunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lunch", for: indexPath) as! LunchViewCell
        if let dataModel = viewModel.dataModel{
            let model = dataModel.restaurants[indexPath.row]
            lunchCell.configCell(model: model)
        }
        return lunchCell
        
    }
    
    
}

extension LunchViewController : UICollectionViewDelegateFlowLayout {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let screenWidth = collectionView.frame.size.width
    //
    //        return CGSize(width: screenWidth, height: 180.0)
    //
    //
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 1.0, bottom: 0.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            let screenWidth = collectionView.frame.size.width
            return CGSize(width: screenWidth, height: 180.0)
            
        }else{
            
          let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let dataModel = viewModel.dataModel{
            let model = dataModel.restaurants[indexPath.row]
            detailViewController.model = model
        }
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
}
