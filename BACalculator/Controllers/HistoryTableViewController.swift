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
    
    /// The `Drink`s logged by the `Drinker`, grouped by the start of each `Drink`'s `consumptionDate`. Each `[Drink]` value is sorted in desending order by `consumptionDate`.
    var drinksByDate: [Date: [Drink]]?
    /// The start of `Date`s that have `Drink`s logged, sorted in descending order.
    var days: [Date]? {
        return drinksByDate?.keys.sorted().reversed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        groupDrinks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func groupDrinks() {
        let unsortedDrinks = DrinkManager.default.drinks!
        let unsortedDrinksByDate = Dictionary(grouping: unsortedDrinks, by: { Calendar.current.startOfDay(for: $0.consumptionDate) })
        drinksByDate = unsortedDrinksByDate.mapValues({ return $0.sortedByDate().reversed() })
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return days!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksByDate![days![section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyEntry") as! HistoryTableViewCell
        let drinkForCell = drinksByDate![days![indexPath.section]]![indexPath.row]
        cell.typeLabel.text = drinkForCell.type.description.localizedCapitalized
        cell.sizeLabel.text = drinkForCell.size.description(forType: drinkForCell.type)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        cell.dateLabel.text = dateFormatter.string(from: drinkForCell.consumptionDate)
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let detailHeaderView = DetailHeaderView()
        // Update header style
        if let themeNavigationController = navigationController as? ThemeNavigationViewController {
            detailHeaderView.backgroundColor = themeNavigationController.themeColor?.dark
        }
        detailHeaderView.textLabel.textColor = .white
        detailHeaderView.detailTextLabel.textColor = .white
        // Update header text
        let dateForHeader = days![section]
        if Calendar.current.isDateInToday(dateForHeader) {
            detailHeaderView.textLabel.text = "Today"
        } else if Calendar.current.isDateInYesterday(dateForHeader) {
            detailHeaderView.textLabel.text = "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            detailHeaderView.textLabel.text = dateFormatter.string(from: dateForHeader)
        }
        detailHeaderView.detailTextLabel.text = nil
        return detailHeaderView
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let drinkToRemove = drinksByDate![days![indexPath.section]]![indexPath.row]
            let drinkIndex = DrinkManager.default.drinks.index { (drink) -> Bool in
                return drink.consumptionDate == drinkToRemove.consumptionDate && drink.type == drinkToRemove.type
            }!
            DrinkManager.default.drinks.remove(at: drinkIndex)
            groupDrinks()
            if drinksByDate![Calendar.current.startOfDay(for: drinkToRemove.consumptionDate)] == nil {
                tableView.deleteSections([indexPath.section], with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

}
