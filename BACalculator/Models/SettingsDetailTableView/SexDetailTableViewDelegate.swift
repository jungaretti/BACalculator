//
//  SexDetailTableViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class SexDetailTableViewDelegate: SettingsDetailTableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for visibleCell in tableView.visibleCells {
            visibleCell.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        DrinkerInformationManager.drinkerInformation.sex = SexDetailTableViewDataSource.sexes[indexPath.row]
    }
    
}
