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
    
    private var _customSize: Bool = false
    
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
        switch section {
        case 0:
            return 1
        case 1:
            if _customSize {
                return 2
            } else {
                return 1
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! AttributeHeaderTableViewCell
            cell.attributeLabel.text = "Type"
            cell.contentView.backgroundColor = tableView.backgroundColor
            return cell.contentView
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerAction") as! AttributeHeaderActionTableViewCell
            cell.attributeLabel.text = "Size"
            if _customSize {
                cell.attributeButton.setTitle("Use Standard Size", for: .normal)
            } else {
                cell.attributeButton.setTitle("Use Custom Size", for: .normal)
            }
            cell.attributeButton.addTarget(self, action: #selector(toggleSizeMode(_:)), for: .touchUpInside)
            cell.contentView.backgroundColor = tableView.backgroundColor
            return cell.contentView
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        // Type
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionView") as! AttributeCollectionTableViewCell
            cell.setCollectionView(dataSource: TypeAttributeOptionCollectionViewDataSource())
            return cell
        // Size
        case 1:
            switch indexPath.row {
            case 0:
                if _customSize {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! AttributeDetailTableViewCell
                    cell.textLabel?.text = "Volume"
                    cell.detailTextLabel?.text = "Value"
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "collectionView") as! AttributeCollectionTableViewCell
                    cell.setCollectionView(dataSource: SizeAttributeOptionCollectionViewDataSource())
                    return cell
                }
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! AttributeDetailTableViewCell
                cell.textLabel?.text = "Alcohol Ratio"
                cell.detailTextLabel?.text = "Value"
                return cell
            default:
                break
            }
        default:
            break
        }
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cardRowHeight = CGFloat(172.0)
        let detailRowHeight = CGFloat(54.0)
        switch indexPath.section {
        case 0:
            return cardRowHeight
        case 1:
            if _customSize {
                return detailRowHeight
            } else {
                return cardRowHeight
            }
        default:
            break
        }
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
