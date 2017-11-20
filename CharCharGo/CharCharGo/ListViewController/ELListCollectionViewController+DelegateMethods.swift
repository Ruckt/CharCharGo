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
        return self.characterListArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ELCharacterProfileCollectionViewCell.kCellIdentifier,
                                                            for: indexPath) as? ELCharacterProfileCollectionViewCell
            else {
                print("Unable to dequeue a thumbnail cell")
                return UICollectionViewCell.init()
        }
        
//        let specs = self.thumbnailsArray[indexPath.row % (self.thumbnailsArray.count - 1)]
//
//        if let image = specs.image {
//            cell.configureWithImage(image, CGFloat(self.randomPadding))
//        }

        //        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = self.randomCellSize
//        return CGSize(width: size, height: 64);
}



//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//        let object = objects[indexPath.row] as! NSDate
//        cell.textLabel!.text = object.description
//        return cell
//    }
//

