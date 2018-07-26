//
//  HomeViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit
import os.log

/// A view controller that specializes in managing the home view of BACalculator.
class HomeViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var historyButton: UIBarButtonItem!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var advanceButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bloodAlcoholContentLabel: UILabel!
    
    private var hoursOffset: Int = 0
    private var timeIntervalOffset: TimeInterval {
        return TimeInterval(3600 * hoursOffset)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInformation(animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInformation(animated: Bool) {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: DrinkerInformationManager.drinkerInformation)
        let measureDate = Date().addingTimeInterval(timeIntervalOffset)
        let bloodAlcoholContent = alcoholCalculator.bloodAlcoholContent(atDate: measureDate, afterDrinks: DrinkManager.drinks)
        os_log("Calculated BAC to be %f at %@.", bloodAlcoholContent, measureDate.description)
        updateBloodAlcoholContentLabel(forBAC: bloodAlcoholContent)
        updateBackgroundColor(forBAC: bloodAlcoholContent)
    }
    
    func offsetHours(by hours: Int) {
        hoursOffset += hours
        updateTimeLabel()
        updateInformation(animated: true)
    }
    
    private func updateTimeLabel() {
        if hoursOffset < -1 {
            timeLabel.text = "\(abs(hoursOffset)) Hours Ago"
        } else if hoursOffset == -1 {
            timeLabel.text = "1 Hour Ago"
        } else if hoursOffset > 1 {
            timeLabel.text = "In \(hoursOffset) Hours"
        } else if hoursOffset == 1 {
            timeLabel.text = "In 1 Hour"
        } else {
            timeLabel.text = "Right Now"
        }
    }
    
    private func updateBloodAlcoholContentLabel(forBAC bloodAlcoholContent: BloodAlcoholContent) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        bloodAlcoholContentLabel.text = numberFormatter.string(from: NSNumber(value: bloodAlcoholContent))
    }
    
    private func updateBackgroundColor(forBAC bloodAlcoholContent: BloodAlcoholContent) {
        if bloodAlcoholContent <= 0.02 {
            view.backgroundColor = UIColor(named: "Green")
        } else if bloodAlcoholContent <= 0.06 {
            view.backgroundColor = UIColor(named: "Orange")
        } else {
            view.backgroundColor = UIColor(named: "Red")
        }
    }
    
    @IBAction func timeControlPressed(_ sender: TimeControlButton) {
        offsetHours(by: sender.hourStep)
    }
    
}
