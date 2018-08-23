//
//  AddDrinkTableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class AddDrinkTableViewController: UITableViewController, AttributeDelegate {
    
    private struct AddDrinkTableViewRowHeights {
        
        static let collectionViewRow = CGFloat(172.0)
        static let detailCollapsedRow = CGFloat(54.0)
        static let detailExpandedRow = CGFloat(144.0)
        
    }
    
    // MARK: Properties
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
        
    private var _customSize: Bool = false
    private var _customVolumeExpanded: Bool = false
    private var _customAlcoholRatioExpanded: Bool = false
    private var _selectedType: DrinkType? = nil
    private var _selectedStandardSize: StandardDrinkSize? = nil
    private var _selectedVolume: Measurement<UnitVolume>? = nil
    private var _selectedAlcoholRatio: Double? = nil
    private var _selectedDate: Date? = nil
    private var _readyToAddStandardSize: Bool {
        return (_selectedType != nil) && (_selectedStandardSize != nil)
    }
    private var _readyToAddCustomSize: Bool {
        return (_selectedType != nil) && (_selectedVolume != nil) && (_selectedAlcoholRatio != nil)
    }
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = false
        self.addButton.isEnabled = false
        if let coloredBarNavigationController = navigationController as? ColoredBarNavigationController {
            tableView.backgroundColor = coloredBarNavigationController.preferredViewBackgroundColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        DrinkManager.default.drinks.append(assembleDrink())
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func toggleSizeMode(_ sender: UIButton) {
        _customSize = !(_customSize)
        if _customSize {
            _customVolumeExpanded = false
            _customAlcoholRatioExpanded = false
            _selectedVolume = nil
            _selectedAlcoholRatio = nil
        } else {
            _selectedStandardSize = nil
        }
        updateAddButtonState()
        tableView.reloadSections([1], with: .left)
    }
    
    func typeAttributeDidChange(sender: UICollectionView) {
        if let indexPathForSelectedItem = sender.indexPathsForSelectedItems?.first {
            _selectedType = DrinkAttribute.types[indexPathForSelectedItem.row]
        } else {
            _selectedType = nil
        }
        updateAddButtonState()
    }
    
    func standardSizeAttributeDidChange(sender: UICollectionView) {
        if let indexPathForSelectedItem = sender.indexPathsForSelectedItems?.first {
            _selectedStandardSize = StandardDrinkSize(standardDrinks: Double(DrinkAttribute.standardSizes[indexPathForSelectedItem.row]))
        } else {
            _selectedStandardSize = nil
        }
        updateAddButtonState()
    }
    
    func volumeAttributeDidChange(sender: UIPickerView) {
        let value = VolumePickerViewDataSource.values[sender.selectedRow(inComponent: 0)]
        let unit = VolumePickerViewDataSource.units[sender.selectedRow(inComponent: 1)]
        _selectedVolume = Measurement(value: value, unit: unit)
        updateAddButtonState()
    }
    
    func alcoholRatioAttributeDidChange(sender: UIPickerView) {
        _selectedAlcoholRatio = AlcoholRatioPickerViewDataSource.alcoholRatios[sender.selectedRow(inComponent: 0)] / 100.0
        updateAddButtonState()
    }
    
    func dateAttributeDidChange(sender: UIDatePicker) {
        _selectedDate = sender.date
        updateAddButtonState()
    }
    
    private func updateAddButtonState() {
        if _customSize {
            self.addButton.isEnabled = self._readyToAddCustomSize
        } else {
            self.addButton.isEnabled = self._readyToAddStandardSize
        }
    }
    
    private func assembleDrink() -> Drink {
        let type = _selectedType!
        let size: DrinkSize
        if _customSize {
            size = CustomDrinkSize(volume: _selectedVolume!, alcoholRatio: _selectedAlcoholRatio!)
        } else {
            size = _selectedStandardSize!
        }
        let date = Date()
        return Drink(type: type, consumptionDate: date, size: size)
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        // Type
        case 0:
            return 1
        // Size
        case 1:
            if _customSize { return 2 }
            else { return 1 }
        default:
            break
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell: AttributeHeaderTableViewCell
        switch section {
        // Type
        case 0:
            headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as! AttributeHeaderTableViewCell
            headerCell.attributeLabel.text = "Type"
        // Size
        case 1:
            let headerActionCell = tableView.dequeueReusableCell(withIdentifier: "headerAction") as! AttributeHeaderActionTableViewCell
            headerActionCell.attributeLabel.text = "Size"
            // Set size title
            if _customSize {
                headerActionCell.attributeButton.setTitle("Use Standard Size", for: .normal)
            } else {
                headerActionCell.attributeButton.setTitle("Use Custom Size", for: .normal)
            }
            headerActionCell.attributeButton.addTarget(self, action: #selector(toggleSizeMode(_:)), for: .touchUpInside)
            headerCell = headerActionCell
        default:
            
            return nil
        }
        headerCell.contentView.backgroundColor = tableView.backgroundColor
        return headerCell.contentView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        // Type
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionView") as! AttributeCollectionTableViewCell
            cell.setCollectionView(dataSource: TypeAttributeOptionCollectionViewDataSource())
            cell.setCollectionView(delegate: TypeAttributeOptionCollectionViewDelegate(), attributeOptionDelegate: self)
            return cell
        // Size
        case 1:
            switch indexPath.row {
            case 0:
                if _customSize {
                    // Volume
                    var detailCell = tableView.dequeueReusableCell(withIdentifier: "detail") as! AttributeDetailTableViewCell
                    if _customVolumeExpanded {
                        let detailPickerCell = tableView.dequeueReusableCell(withIdentifier: "detailPicker") as! AttributeDetailPickerTableViewCell
                        detailPickerCell.setPickerView(dataSouce: VolumePickerViewDataSource())
                        detailPickerCell.setPickerView(delegate: VolumePickerViewDelegate(), attributeOptionDelegate: self)
                        detailCell = detailPickerCell
                    }
                    detailCell.textLabel?.text = "Volume"
                    detailCell.detailTextLabel?.text = _selectedVolume?.description
                    return detailCell
                } else {
                    // Collection view
                    let cell = tableView.dequeueReusableCell(withIdentifier: "collectionView") as! AttributeCollectionTableViewCell
                    cell.setCollectionView(dataSource: SizeAttributeOptionCollectionViewDataSource())
                    cell.setCollectionView(delegate: SizeAttributeOptionCollectionViewDelegate(), attributeOptionDelegate: self)
                    return cell
                }
            // Alcohol ratio
            case 1:
                // Volume
                var detailCell = tableView.dequeueReusableCell(withIdentifier: "detail") as! AttributeDetailTableViewCell
                if _customAlcoholRatioExpanded {
                    let detailPickerCell = tableView.dequeueReusableCell(withIdentifier: "detailPicker") as! AttributeDetailPickerTableViewCell
                    detailPickerCell.setPickerView(dataSouce: AlcoholRatioPickerViewDataSource())
                    detailPickerCell.setPickerView(delegate: AlcoholRatioPickerViewDelegate(), attributeOptionDelegate: self)
                    detailCell = detailPickerCell
                }
                detailCell.textLabel?.text = "Alcohol Ratio"
                if let selectedAlcoholRatio = self._selectedAlcoholRatio {
                    // TODO: Move the "VALUE %" formatter somewhere else
                    detailCell.detailTextLabel?.text = "\(selectedAlcoholRatio) %"
                } else {
                    detailCell.detailTextLabel?.text = nil
                }
                return detailCell
            default:
                break
            }
        default:
            break
        }
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        // Type
        case 0:
            return AddDrinkTableViewRowHeights.collectionViewRow
        // Size
        case 1:
            if _customSize {
                if let selectedCell = tableView.cellForRow(at: indexPath), selectedCell.isSelected {
                    return AddDrinkTableViewRowHeights.detailExpandedRow
                } else {
                    return AddDrinkTableViewRowHeights.detailCollapsedRow
                }
            } else {
                return AddDrinkTableViewRowHeights.collectionViewRow
            }
        default:
            break
        }
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                if _customVolumeExpanded == false {
                    _customVolumeExpanded = true
                    _customAlcoholRatioExpanded = false
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            } else if indexPath.row == 1 {
                if _customAlcoholRatioExpanded == false {
                    _customVolumeExpanded = false
                    _customAlcoholRatioExpanded = true
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
}
