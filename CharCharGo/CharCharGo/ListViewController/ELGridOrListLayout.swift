//
//  ELGridFlowLayout.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/24/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

class ELGridOrListLayout: UICollectionViewFlowLayout {
    
    var isGridLayout = true
    
    var itemHeight: CGFloat {
        get {
            return (self.isGridLayout ? 150 : 70)
        }
    }
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /// Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
    func setupLayout() {
        if isGridLayout {
            minimumInteritemSpacing = 1
        } else {
            minimumInteritemSpacing = 0
        }
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }

    func itemWidth() -> CGFloat {
        guard let width = collectionView?.frame.width else { return 50.0}
        
        if isGridLayout {
            let columns : CGFloat = 3
            return (width/columns)-1
        } else {
            guard let width = collectionView?.frame.width else { return 50.0}
            return width

        }
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
