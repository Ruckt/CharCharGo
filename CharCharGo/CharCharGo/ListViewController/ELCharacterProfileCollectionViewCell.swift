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
    
    var universalPadding : CGFloat = 0.0
    
    static let kCellIdentifier = "CharacterProfileCellID"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        imageView.image = nil
//        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureWithImage(_ image: UIImage?, _ padding: CGFloat) {
        
        universalPadding = padding
        //        leftPadding.constant = padding
        //        rightPadding.constant = padding
        // bottomPadding.constant = padding
        //topPadding.constant = padding
  //      setPadding()
        
        
        if let image = image {
            imageView.image = image
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
