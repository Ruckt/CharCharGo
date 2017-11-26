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
        return self.characterProfileWithImagesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ELCharacterProfileCollectionViewCell.kCellIdentifier,
                                                            for: indexPath) as? ELCharacterProfileCollectionViewCell
            else {
                print("Unable to dequeue a thumbnail cell")
                return UICollectionViewCell.init()
        }
        
        let profileWImage : ELCharacterProfilelPlusImageData = self.characterProfileWithImagesArray[indexPath.row]
        
        let name = profileWImage.profile.name
        let image = profileWImage.image
        
        cell.configureWithProfile(name, image, collectionVC: self)

        return cell
    }
}
