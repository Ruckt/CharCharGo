//
//  ELListCollectionViewController.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

class ELListCollectionViewController: UICollectionViewController {
    
    // UI properties
    @IBOutlet var layoutChangeButton: UIBarButtonItem!
    
    var detailViewController: DetailViewController? = nil
    let gridFlowLayout = ELGridFlowLayout()
    let listFlowLayout = ELListFlowLayout()
    
    // Data properties
    let networkManager = ELNetworkManager()
    var characterProfileArray : ELCharacterProfileArray = []

    lazy var activityIndicator : UIActivityIndicatorView = {
        
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.color = UIColor.blue
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        activityIndicator.frame = CGRect(x: screenSize.width/2 - 25,
                                         y: screenSize.height/2 - 100,
                                         width: 50.0,
                                         height: 50.0)
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        collectionView!.collectionViewLayout = gridFlowLayout
        layoutChangeButton.title = "To List"
        
        initiateRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }
    
    func initiateRequest () {
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        networkManager.requestCharachers {  [weak self] (characterProfiles) in
                if let characterProfiles = characterProfiles {
                    self?.characterProfileArray = characterProfiles
                }
            
            DispatchQueue.main.async { () in
                if self?.activityIndicator.isAnimating == true {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                }
                
                self?.collectionView?.reloadData()
            }
            }
    }
    
    // MARK: Action Functions
    
    @IBAction func layoutChangeButtonPressed() {
        guard let collectionView = self.collectionView else {return}
        
        if collectionView.collectionViewLayout == gridFlowLayout {
            UIView.animate(withDuration: 0.2) { () -> Void in
                collectionView.collectionViewLayout.invalidateLayout()
                collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
                self.layoutChangeButton.title = "To Grid"
            }
        } else {
            UIView.animate(withDuration: 0.2) { () -> Void in
                collectionView.collectionViewLayout.invalidateLayout()
                collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
                self.layoutChangeButton.title = "To List"
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            //            if let indexPath = tableView.indexPathForSelectedRow {
            //                let object = objects[indexPath.row] as! NSDate
            //                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            //                controller.detailItem = object
            //                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            //                controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}
