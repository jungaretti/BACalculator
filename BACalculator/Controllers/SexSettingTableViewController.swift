//
//  SexSettingTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class SexSettingTableViewController: SettingsDetailTableViewController {
    
    static let sexes: [DrinkerSex] = [.male, .female]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func sex(forIndexPath indexPath: IndexPath) -> DrinkerSex {
        return SexSettingTableViewController.sexes[indexPath.row]
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SexSettingTableViewController.sexes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = masterTableView!.dequeueReusableCell(withIdentifier: "basic") as! SettingBasicTableViewCell
        let sex = self.sex(forIndexPath: indexPath)
        cell.textLabel?.text = sex.description.localizedCapitalized
        if let currentSex = DrinkerManager.default.drinker?.sex, currentSex == sex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Determine the new sex
        let sex = self.sex(forIndexPath: indexPath)
        // Deselect all visible cells
        for visibleCell in tableView.visibleCells {
            visibleCell.accessoryType = .none
        }
        // Update the new cell, if possible
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        // Update the data source
        DrinkerManager.default.update(sex: sex)
        // Deselect the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
