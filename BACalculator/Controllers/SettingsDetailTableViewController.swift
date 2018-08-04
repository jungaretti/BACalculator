//
//  SettingsDetailTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsDetailTableViewController: UITableViewController, SettingsDetailDelegate {
    
    weak var delegate: SettingsDelegate?
        
    weak var masterTableViewCell: SettingsTableViewCell!
    private var tableViewDataSource: SettingsDetailTableViewDataSource?
    private var tableViewDelegate: SettingsDetailTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataSourceType = masterTableViewCell.detailTableViewDataSourceType {
            self.tableViewDataSource = dataSourceType.init()
            tableView.dataSource = self.tableViewDataSource
        }
        if let delegateType = masterTableViewCell.detailTableViewDelegateType {
            self.tableViewDelegate = delegateType.init()
            tableView.delegate = self.tableViewDelegate
        }
        self.title = masterTableViewCell.textLabel?.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.didFinishEditingDetail(sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func detailDidChange(sender: Any) {}

}
