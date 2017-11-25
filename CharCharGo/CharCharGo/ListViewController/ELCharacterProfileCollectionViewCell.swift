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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
//    @IBOutlet var rightPadding: NSLayoutConstraint!
//    @IBOutlet var topPadding: NSLayoutConstraint!
//    @IBOutlet var bottomPadding: NSLayoutConstraint!
    
    static let kCellIdentifier = "CharacterProfileCellID"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
    }
    
    func configureWithProfile(_ name: String, _ image: UIImage?) {
        
        self.nameLabel.text = name

        if let image = image {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "selfie.png")
        }
    }
    
//    func setPadding() {
//        leftPadding.constant = universalPadding
//        rightPadding.constant = universalPadding
//    }
//
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    //    setPadding()
    }
}
