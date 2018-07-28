//
//  DrinkTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attribute") as! DrinkAttributeTableViewCell
        switch indexPath.row {
        case 0:
            cell.attributeLabel.text = "Type"
            cell.attributeButton.removeFromSuperview()
            let collectionViewDataSource = DrinkTypeAttributeOptionCollectionViewDataSource()
            cell.setCollectionView(dataSource: collectionViewDataSource)
            
        case 1:
            cell.attributeLabel.text = "Size"
            cell.attributeButton.setTitle("Use Custom Size", for: .normal)
            let collectionViewDataSource = DrinkSizeAttributeOptionCollectionViewDataSource()
            cell.setCollectionView(dataSource: collectionViewDataSource)
        default:
            break
        }
        (cell.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 120.0, height: cell.collectionView.frame.height)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 206.0
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
