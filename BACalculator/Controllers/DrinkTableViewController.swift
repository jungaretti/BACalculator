//
//  DrinkTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private var _customSize: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! DrinkAttributeHeaderTableViewCell
            cell.attributeLabel.text = "Type"
            cell.backgroundColor = tableView.backgroundColor
            return cell.contentView
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerAction") as! DrinkAttributeActionHeaderTableViewCell
            cell.attributeLabel.text = "Size"
            if _customSize {
                cell.attributeButton.setTitle("Use Standard Size", for: .normal)
            } else {
                cell.attributeButton.setTitle("Use Custom Size", for: .normal)
            }
            cell.attributeButton.addTarget(self, action: #selector(toggleSizeMode(_:)), for: .touchUpInside)
            cell.backgroundColor = tableView.backgroundColor
            return cell.contentView
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionView") as! DrinkAttributeCollectionTableViewCell
        switch indexPath.section {
        // Drink type
        case 0:
            cell.setCollectionView(dataSource: DrinkTypeAttributeOptionCollectionViewDataSource())
        // Drink size
        case 1:
            cell.setCollectionView(dataSource: DrinkSizeAttributeOptionCollectionViewDataSource())
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172.0
    }
    
    @objc func toggleSizeMode(_ sender: UIButton) {
        self._customSize = !(_customSize)
        self.tableView.reloadSections([1], with: .automatic)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
