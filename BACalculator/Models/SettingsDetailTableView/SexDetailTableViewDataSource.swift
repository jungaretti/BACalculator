//
//  SexDetailTableViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation
import UIKit

class SexDetailTableViewDataSource: SettingsDetailTableViewDataSource {
    
    static let sexes: [DrinkerSex] = [DrinkerSex.male, DrinkerSex.female]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SexDetailTableViewDataSource.sexes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choice")!
        let sexForCell = SexDetailTableViewDataSource.sexes[indexPath.row]
        cell.textLabel?.text = sexForCell.description
        cell.detailTextLabel?.text = nil
        if sexForCell == DrinkerInformationManager.default.drinkerInformation?.sex {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
}
