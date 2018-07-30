//
//  TypeAttributeOptionCollectionViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

/// An `UICollectionViewDataSource` that specializes in displaying a collection of `DrinkType` options.
class TypeAttributeOptionCollectionViewDataSource: AttributeOptionCollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrinkAttributeManager.types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type", for: indexPath) as! AttributeOptionCollectionViewCell
        let card = cell.card as! TypeAttributeCardView
        let type = DrinkAttributeManager.types[indexPath.row]
        card.imageView.image = DrinkAttributeManager.icon(forType: type)
        card.detailTextLabel.text = type.description
        if cell.isSelected {
            card.setSelectedState(.selected, animated: false)
        } else {
            card.setSelectedState(.deselected, animated: false)
        }
        return cell
    }

}
