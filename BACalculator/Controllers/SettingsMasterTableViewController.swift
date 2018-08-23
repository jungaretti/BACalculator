//
//  SettingsMasterTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsMasterTableViewController: UITableViewController, SettingsDelegate {
    
    let settingsBySection: [Int: [AppSetting]] = [
        0: [.weight, .sex]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func settingDidChange() {
        tableView.reloadData()
    }
    
    private func settings(forSection section: Int) -> [AppSetting] {
        return settingsBySection[section]!
    }
    
    private func setting(forIndexPath indexPath: IndexPath) -> AppSetting {
        return settingsBySection[indexPath.section]![indexPath.row]
    }
    
    private func cell(forSetting setting: AppSetting) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! SettingDetailTableViewCell
        cell.textLabel?.text = setting.title
        cell.detailTextLabel?.text = setting.value
        if setting.showModifyInDetailViewController {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    private func detailViewController(forSetting setting: AppSetting) -> UIViewController? {
        let detailViewController = setting.detailViewController
        detailViewController?.delegate = self
        detailViewController?.masterTableView = tableView
        detailViewController?.setting = setting
        return detailViewController
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsBySection.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings(forSection: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(forSetting: setting(forIndexPath: indexPath))!
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewControllerForCell = detailViewController(forSetting: setting(forIndexPath: indexPath)) {
            show(detailViewControllerForCell, sender: self)
        }
    }

}
