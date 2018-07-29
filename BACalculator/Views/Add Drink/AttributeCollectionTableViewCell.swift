//
//  AttributeCollectionTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/28/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

/// An `AttributeTableViewCell` that specializes in displaying a collection view.
class AttributeCollectionTableViewCell: AttributeTableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var collectionViewDataSource: UICollectionViewDataSource?
    private var collectionViewDelegate: UICollectionViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCollectionView(dataSource: UICollectionViewDataSource?) {
        self.collectionViewDataSource = dataSource
        collectionView.dataSource = self.collectionViewDataSource
    }
    
    func setCollectionView(delegate: UICollectionViewDelegate?) {
        self.collectionViewDelegate = delegate
        collectionView.delegate = self.collectionViewDelegate
    }

}
