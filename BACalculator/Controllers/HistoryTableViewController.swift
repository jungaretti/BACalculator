//
//  HistoryTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class HistoryTableViewController: UITableViewController {
    
    // MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let editButtonAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: CGFloat(17.0))!,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(editButtonAttributes, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DrinkManager.drinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drink") as! DrinkTableViewCell
        let drink = DrinkManager.drinks[indexPath.row]
        cell.typeLabel.text = drink.type.description
        cell.sizeLabel.text = "\(drink.size)"
        cell.dateLabel.text = drink.consumptionDate.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DrinkManager.drinks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
}
