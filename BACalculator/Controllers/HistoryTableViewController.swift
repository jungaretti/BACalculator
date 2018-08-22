//
//  HistoryTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/19/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class HistoryTableViewController: UITableViewController {
    
    /// The `Drink`s to display, keyed by the start of each `Drink`'s `consumptionDate`. Each `[Drink]` value is sorted from youngest to oldest.
    private var drinksByDate: [Date: [Drink]]?
    /// The start of `Date`s to display, sorted from youngest to oldest.
    private var dates: [Date]? {
        return drinksByDate?.keys.sorted().reversed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = self.editButtonItem
        let editButtonAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 17.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
        ]
        editButton.setTitleTextAttributes(editButtonAttributes, for: .normal)
        editButton.setTitleTextAttributes(editButtonAttributes, for: .highlighted)
        editButton.tintColor = UIColor.white
        navigationItem.setRightBarButton(editButton, animated: false)
        groupDrinks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func groupDrinks() {
        var drinksByDate = Dictionary(grouping: DrinkManager.default.drinks, by: { Calendar.current.startOfDay(for: $0.consumptionDate) })
        drinksByDate = drinksByDate.mapValues({ (drinks) -> [Drink] in
            // Sort `[Drink]` value by `Date` from youngest to oldest
            return drinks.sortedByDate().reversed()
        })
        self.drinksByDate = drinksByDate
    }
    
    private func drinkForIndexPath(_ indexPath: IndexPath) -> Drink {
        return drinksByDate![dateForSection(indexPath.section)]![indexPath.row]
    }
    
    private func drinksForSection(_ section: Int) -> [Drink] {
        return drinksByDate![dateForSection(section)]!
    }
    
    private func dateForSection(_ section: Int) -> Date {
        return dates![section]
    }
    
    private func timeText(forDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    private func dateText(forDate date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dates!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksForSection(section).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyEntry") as! HistoryTableViewCell
        let drink = drinkForIndexPath(indexPath)
        cell.typeLabel.text = drink.type.description
        cell.sizeLabel.text = drink.size.description(forType: drink.type)
        cell.dateLabel.text = timeText(forDate: drink.consumptionDate)
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.textLabel.text = dateText(forDate: dateForSection(section))
        headerView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let drinkForIndexPath = self.drinkForIndexPath(indexPath)
        if editingStyle == .delete {
            // Determine the index of the drink to remove
            let indexOfDrinkToRemove = DrinkManager.default.drinks.index(of: drinkForIndexPath)!
            // Determine if the section needs to be removed
            let sectionShouldBeRemoved = drinksForSection(indexPath.section).count == 1
            // Remove the drink from the data source
            DrinkManager.default.drinks.remove(at: indexOfDrinkToRemove)
            // Regroup drinks from the data source
            groupDrinks()
            // Remove the row or section
            if sectionShouldBeRemoved {
                tableView.deleteSections([indexPath.section], with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

}
