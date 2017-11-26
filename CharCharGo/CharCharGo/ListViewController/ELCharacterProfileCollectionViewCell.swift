//
//  ELCharacterProfileCollectionViewCell.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

class ELCharacterProfileCollectionViewCell: UICollectionViewCell {
    
    static let kCellIdentifier = "CharacterProfileCellID"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @objc weak var collectionVC: ELListCollectionViewController?
    var observation: NSKeyValueObservation?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
    }
    
    func configureWithProfile(_ name: String, _ image: UIImage?, collectionVC: ELListCollectionViewController?) {
        
        self.nameLabel.text = name
        self.collectionVC = collectionVC

        if let image = image {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "selfie.png")
        }
        
        if let isGridLayout = self.collectionVC?.isGridLayout {
            self.nameLabel.isHidden = isGridLayout
            self.imageView.isHidden = !isGridLayout
        }
        
        observation = self.collectionVC?.observe(\.isGridLayout) { object, change in
            if let isGridLayout = self.collectionVC?.isGridLayout {
                self.nameLabel.isHidden = isGridLayout
                self.imageView.isHidden = !isGridLayout
            }
        }
    }
}
