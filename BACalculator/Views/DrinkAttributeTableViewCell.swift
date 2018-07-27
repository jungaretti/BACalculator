//
//  DrinkAttributeTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class DrinkAttributeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attributeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewDataSource: UICollectionViewDataSource?
    var collectionViewDelegate: UICollectionViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
