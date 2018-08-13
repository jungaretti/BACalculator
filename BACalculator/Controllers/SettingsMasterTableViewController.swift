//
//  SettingsMasterTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsMasterTableViewController: UITableViewController, SettingsDelegate {
    
    // MARK: Properties
    
    weak var calculationDelegate: CalculationDelegate!
    
    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        calculationDelegate.calculationVariableDidChange()
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFinishEditingDetail(sender: Any) {
        if let sender = sender as? SettingsDetailTableViewController {
            if let indexPath = tableView.indexPath(for: sender.masterTableViewCell) {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        } else {
            tableView.reloadData()
        }
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            break
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: SettingsTableViewCell
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! SettingsTableViewCell
                cell.textLabel?.text = "Sex"
                cell.detailTextLabel?.text = DrinkerInformationManager.default.drinkerInformation?.sex.description
                cell.detailTableViewDataSourceType = SexDetailTableViewDataSource.self
                cell.detailTableViewDelegateType = SexDetailTableViewDelegate.self
                return cell
            case 1:
                let pickerCell = tableView.dequeueReusableCell(withIdentifier: "picker") as! SettingsPickerTableViewCell
                pickerCell.textLabel?.text = "Weight"
                pickerCell.detailTextLabel?.text = DrinkerInformationManager.default.drinkerInformation?.weight.description
                pickerCell.pickerViewDataSourceType = WeightPickerViewDataSource.self
                pickerCell.pickerViewDelegateType = WeightPickerViewDelegate.self
                pickerCell.detailTextLabelUpdateFunction = {
                    return DrinkerInformationManager.default.drinkerInformation?.weight.description
                }
                cell = pickerCell
                return cell
            default:
                break
            }
        default:
            break
        }
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Personal Information"
        default:
            return nil
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SettingsDetailTableViewController, let selectedRow = tableView.indexPathForSelectedRow {
            destination.masterTableViewCell = tableView.cellForRow(at: selectedRow) as! SettingsTableViewCell
            destination.delegate = self
        }
    }

}
