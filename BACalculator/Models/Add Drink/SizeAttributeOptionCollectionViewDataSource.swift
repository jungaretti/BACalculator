//
//  SizeAttributeOptionCollectionViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

/// An `UICollectionViewDataSource` that specializes in displaying a collection of standard `StandardDrinkSize` choices.
class SizeAttributeOptionCollectionViewDataSource: AttributeOptionCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrinkManager.standardSizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "size", for: indexPath) as! AttributeOptionCollectionViewCell
        let card = cell.card as! SizeAttributeCardView
        let standardDrinkSize = DrinkManager.standardSizes[indexPath.row]
        card.textLabel.text = "\(standardDrinkSize)"
        if standardDrinkSize == 1 {
            cell.card.detailTextLabel.text = "Standard Drink"
        } else {
            cell.card.detailTextLabel.text = "Standard Drinks"
        }
        return cell
    }

}