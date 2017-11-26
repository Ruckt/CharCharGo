//
//  ELListCollectionViewController+DataSource.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

extension ELListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterProfileArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ELCharacterProfileCollectionViewCell.kCellIdentifier,
                                                            for: indexPath) as? ELCharacterProfileCollectionViewCell
            else {
                print("Unable to dequeue a thumbnail cell")
                return UICollectionViewCell.init()
        }
        
        let profile : ELCharacterProfile = self.characterProfileArray[indexPath.row]
        
        let name = profile.name
        
        cell.configureWithProfile(name, nil, collectionVC: self)
        
//        let specs = self.thumbnailsArray[indexPath.row % (self.thumbnailsArray.count - 1)]
        
//
//        if let image = specs.image {
//            cell.configureWithImage(image, CGFloat(self.randomPadding))
//        }

        //        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
        
        return cell
    }
}
