//
//  AttributeOptionCollectionViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/29/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class AttributeOptionCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    weak var attributeOptionDelegate: AttributeDelegate!

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // If the cell is visible, select it visually
        if let cell = collectionView.cellForItem(at: indexPath) as? AttributeOptionCollectionViewCell {
            cell.card.setSelectedState(.selected, animated: true)
        }
        // If the cell is not visible, reload it
        else {
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // If the cell is visible, deselect it visually
        if let cell = collectionView.cellForItem(at: indexPath) as? AttributeOptionCollectionViewCell {
            cell.card.setSelectedState(.deselected, animated: true)
        }
        // If the cell is not visible, reload it
        else {
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
}
