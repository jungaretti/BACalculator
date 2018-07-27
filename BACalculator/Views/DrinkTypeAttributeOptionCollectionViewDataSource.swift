//
//  DrinkTypeAttributeOptionCollectionViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

private let reuseIdentifier = "Cell"

class DrinkTypeAttributeOptionCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    static let types: [(name: String, type: DrinkType, image: UIImage?)] = [
        ("Beer", .beer, UIImage(named: "Beer")),
        ("Wine", .wine, UIImage(named: "Wine")),
        ("Liquor", .liquor, UIImage(named: "Liquor")),
        ("Mixed", .mixed, UIImage(named: "Mixed"))
        
    ]
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrinkTypeAttributeOptionCollectionViewDataSource.types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type", for: indexPath) as! DrinkAttributeOptionCollectionViewCell
        let cellCard = cell.card as! DrinkTypeAttributeCardView
        cell.card.detailTextLabel.text = DrinkTypeAttributeOptionCollectionViewDataSource.types[indexPath.row].name
        cellCard.imageView.image = DrinkTypeAttributeOptionCollectionViewDataSource.types[indexPath.row].image
        return cell
    }

}
