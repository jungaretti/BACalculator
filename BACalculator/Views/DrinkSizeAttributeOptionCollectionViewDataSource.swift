//
//  DrinkSizeAttributeOptionCollectionViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class DrinkSizeAttributeOptionCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    static let sizes = Array(1...6)
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrinkSizeAttributeOptionCollectionViewDataSource.sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "size", for: indexPath) as! DrinkAttributeOptionCollectionViewCell
        let cellCard = cell.card as! DrinkSizeAttributeCardView
        cellCard.textLabel.text = "\(DrinkSizeAttributeOptionCollectionViewDataSource.sizes[indexPath.row])"
        if DrinkSizeAttributeOptionCollectionViewDataSource.sizes[indexPath.row] == 1 {
            cellCard.detailTextLabel.text = "Standard Drink"
        } else {
            cellCard.detailTextLabel.text = "Standard Drinks"
        }
        return cell
    }

}
