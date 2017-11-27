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
    
    var detailViewController: ELCharacterDetailViewController? = nil
    let gridFlowLayout = ELGridFlowLayout()
    let listFlowLayout = ELListFlowLayout()
    @objc dynamic var isGridLayout: Bool = true
    
    // Data properties
    let networkManager = ELNetworkManager()
    var characterProfileWithImagesArray : ELCharacterProfilelPlusImageDataArray = []

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
        
        self.title = ELCharCharGoConstants.kAPP_TITLE
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ELCharacterDetailViewController
            split.preferredDisplayMode = .allVisible
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
                    self?.characterProfileWithImagesArray = characterProfiles
                }
            
            DispatchQueue.main.async { () in
                if self?.activityIndicator.isAnimating == true {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                }
                
                // For split views, reload displayed detail view controller with first profile in data array
                if let split = self?.splitViewController,
                    let characterProfiles = characterProfiles,
                    characterProfiles.count > 0 {
                    
                        let controllers = split.viewControllers
                        self?.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ELCharacterDetailViewController
                        self?.detailViewController?.characterProfile = characterProfiles[0]
                        self?.detailViewController?.configureView()
                }
                
                self?.collectionView?.reloadData()
            }
        }
    }
    
    // MARK: Action Functions
    
    @IBAction func layoutChangeButtonPressed() {
        guard let collectionView = self.collectionView else {return}
        
        self.isGridLayout = !self.isGridLayout
        
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
        if segue.identifier == "showFullCharacter",
            let cell = sender as? ELCharacterProfileCollectionViewCell,
            let indexPath =  self.collectionView?.indexPath(for: cell),
            let controller = (segue.destination as? UINavigationController)?.topViewController as? ELCharacterDetailViewController {
            
            let profile = self.characterProfileWithImagesArray[indexPath.row] as ELCharacterProfilelPlusImageData
            controller.characterProfile = profile
            
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}
