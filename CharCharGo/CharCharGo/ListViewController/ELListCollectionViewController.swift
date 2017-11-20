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
    
    var detailViewController: DetailViewController? = nil
    
    let networkManager = ELNetworkManager()
    var characterListArray : ELCharacterProfileArray = []

    lazy var activityIndicator : UIActivityIndicatorView = {
        
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.color = UIColor.blue
        if let viewWidth = self.collectionView?.frame.size.width,
            let yCoordinate = self.collectionView?.frame.origin.y {
            activityIndicator.frame = CGRect(x: (viewWidth/2 - 25),
                                             y: yCoordinate + 80,
                                             width: 50.0,
                                             height: 50.0)
        }
        
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
        
        initiateRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initiateRequest () {
        activityIndicator.startAnimating()

        networkManager.requestCharachers {  [weak self] (characterList) in
            DispatchQueue.main.async { () in
                    if self?.activityIndicator.isAnimating == true {
                        self?.activityIndicator.stopAnimating()
                        self?.activityIndicator.removeFromSuperview()
                    }
                }
                
                if let characterList = characterList {
                    self?.characterListArray = characterList
                }
            }
    }
    
    
//    @objc
//    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        //  tableView.insertRows(at: [indexPath], with: .automatic)
//    }
    
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
