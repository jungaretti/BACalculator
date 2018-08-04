//
//  AttributeDetailPickerTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class AttributeDetailPickerTableViewCell: AttributeDetailTableViewCell {
    
    @IBOutlet weak var pickerView: UIPickerView!
    private var pickerViewDataSource: CustomSizePickerViewDataSource?
    private var pickerViewDelegate: CustomSizePickerViewDelegate?
    
    func setPickerView(dataSouce: CustomSizePickerViewDataSource) {
        self.pickerViewDataSource = dataSouce
        self.pickerView.dataSource = self.pickerViewDataSource
    }
    
    func setPickerView(delegate: CustomSizePickerViewDelegate, attributeOptionDelegate: AttributeDelegate) {
        self.pickerViewDelegate = delegate
        self.pickerViewDelegate!.detailTextLabel = self.detailTextLabel
        self.pickerViewDelegate!.attributeOptionDelegate = attributeOptionDelegate
        self.pickerView.delegate = self.pickerViewDelegate
    }
    
}
