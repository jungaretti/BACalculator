//
//  WeightSettingTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class WeightSettingTableViewController: SettingsDetailTableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    static let values: [Double] = Array(1...999).map({ Double($0) })
    static let units: [UnitMass] = [.pounds, .kilograms]
    
    private weak var weightLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PickerTableViewCell", bundle: nil), forCellReuseIdentifier: "picker")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = masterTableView?.dequeueReusableCell(withIdentifier: "detail") as! SettingDetailTableViewCell
            cell.textLabel?.text = setting?.title
            cell.detailTextLabel?.text = setting?.value
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "picker") as! PickerTableViewCell
            cell.pickerView.dataSource = self
            cell.pickerView.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 120.0
        default:
            return 44.0
        }
    }
    
    // MARK: Picker View Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return WeightSettingTableViewController.values.count
        case 1:
            return WeightSettingTableViewController.units.count
        default:
            return 0
        }
    }
    
    // MARK: Picker View Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return WeightSettingTableViewController.values[row].description
        case 1:
            return WeightSettingTableViewController.units[row].symbol
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = WeightSettingTableViewController.values[pickerView.selectedRow(inComponent: 0)]
        let unit = WeightSettingTableViewController.units[pickerView.selectedRow(inComponent: 1)]
        DrinkerManager.default.update(weight: Measurement(value: value, unit: unit))
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }

}
