//
//  SizeAttributeOptionCollectionViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SizeAttributeOptionCollectionViewDelegate: AttributeOptionCollectionViewDelegate {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        attributeOptionDelegate.standardSizeAttributeDidChange(sender: collectionView)
    }
    
}
