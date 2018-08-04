//
//  SettingsPickerDetailTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/4/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsPickerDetailTableViewController: SettingsDetailTableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    private var detailTextLabelUpdateFunction: ( () -> String? )?
    private var pickerViewDataSource: SettingsPickerViewDataSource?
    private var pickerViewDelegate: SettingsPickerViewDelegate?
    
    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        if let masterPickerTableViewCell = self.masterTableViewCell as? SettingsPickerTableViewCell {
            self.pickerViewDataSource = masterPickerTableViewCell.pickerViewDataSourceType?.init()
            pickerView.dataSource = self.pickerViewDataSource
            self.pickerViewDelegate = masterPickerTableViewCell.pickerViewDelegateType?.init()
            self.pickerViewDelegate?.delegate = self
            self.detailTextLabelUpdateFunction = masterPickerTableViewCell.detailTextLabelUpdateFunction
            self.detailTextLabel.text = self.detailTextLabelUpdateFunction?()
            pickerView.delegate = self.pickerViewDelegate
        }
        textLabel.text = masterTableViewCell.textLabel?.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func detailDidChange(sender: Any) {
        super.detailDidChange(sender: sender)
        self.detailTextLabel.text = detailTextLabelUpdateFunction?()
    }

}
