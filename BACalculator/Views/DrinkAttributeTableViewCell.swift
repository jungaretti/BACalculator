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
    private var _collectionViewDataSource: UICollectionViewDataSource?
    private var _collectionViewDelegate: UICollectionViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCollectionView(dataSource: UICollectionViewDataSource) {
        self._collectionViewDataSource = dataSource
        collectionView.dataSource = self._collectionViewDataSource
    }
    
    func setCollectionView(delegate: UICollectionViewDelegate) {
        self._collectionViewDelegate = delegate
        collectionView.delegate = self._collectionViewDelegate
    }

}
