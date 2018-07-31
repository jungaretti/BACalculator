//
//  AttributeOptionDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

/// The `AttributeOptionDelegate` protocol defines methods that allow you manage how an an object responds to an attribute change.
protocol AttributeOptionDelegate: class {
    
    func typeAttributeDidChange(sender: UICollectionView)
    
    func standardSizeAttributeDidChange(sender: UICollectionView)
    
    func volumeAttributeDidChange(sender: UIPickerView)
    
    func alcoholRatioAttributeDidChange(sender: UIPickerView)
    
    func dateAttributeDidChange(sender: UIDatePicker)
    
}
