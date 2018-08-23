//
//  SettingsDetailTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsDetailTableViewController: UITableViewController {
    
    var setting: AppSetting?
    weak var delegate: SettingsDelegate?
    weak var masterTableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = setting?.title
        tableView = UITableView(frame: tableView.frame, style: .grouped)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.settingDidChange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
