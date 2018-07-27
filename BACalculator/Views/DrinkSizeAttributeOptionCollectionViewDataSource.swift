//
//  DrinkSizeAttributeOptionCollectionViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class DrinkSizeAttributeOptionCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrinkAttributeManager.standardDrinkSizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "size", for: indexPath) as! DrinkAttributeOptionCollectionViewCell
        let cellCard = cell.card as! DrinkSizeAttributeCardView
        let standardDrinkSize = DrinkAttributeManager.standardDrinkSizes[indexPath.row]
        cellCard.textLabel.text = "\(standardDrinkSize)"
        cellCard.detailTextLabel.text = DrinkAttributeManager.unitDescription(forStandardDrinks: standardDrinkSize)
        return cell
    }

}
