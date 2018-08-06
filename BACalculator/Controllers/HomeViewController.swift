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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var advanceButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bloodAlcoholContentLabel: UILabel!
    
    private var offsetHours: Int = 0
    private var offsetTimeInterval: TimeInterval {
        return TimeInterval(3600 * offsetHours)
    }
    private var bloodAlcoholContentNumberFormatter = NumberFormatter()
    private var latestBloodAlcoholContentTheme: BloodAlcoholContent = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure colors
        timeLabel.textColor = UIColor.white
        bloodAlcoholContentLabel.textColor = UIColor.white
        for button in [historyButton, settingsButton, rewindButton, addButton, advanceButton] {
            button?.tintColor = UIColor.white
        }
        // Update measurement
        updateTimeLabel(animated: false)
        updateMeasurement(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timeControlPressed(_ sender: HourControlButton) {
        offsetHours += sender.step
        updateTimeLabel(animated: true)
        updateMeasurement(animated: true)
    }
    
    func updateMeasurement(animated: Bool) {
        let bloodAlcoholContent = calculateBloodAlcoholContent()
        let bloodAlcoholContentFormatted = format(bloodAlcoholContent: bloodAlcoholContent)!
        let bloodAlcoholContentTheme = Double(bloodAlcoholContentFormatted)!
        latestBloodAlcoholContentTheme = bloodAlcoholContentTheme
        let updateFunction = {
            // Update the BAC label
            self.bloodAlcoholContentLabel.text = bloodAlcoholContentFormatted
            // Update the background color to match the label
            self.view.backgroundColor = ThemeAgent.themeColor(forBAC: Double(bloodAlcoholContentFormatted)!).normal
        }
        if animated {
            UIView.animate(withDuration: 0.50, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: updateFunction, completion: nil)
        } else {
            updateFunction()
        }
    }
    
    func updateTimeLabel(animated: Bool) {
        if offsetHours < -1 {
            timeLabel.text = "\(abs(offsetHours)) Hours Ago"
        } else if offsetHours == -1 {
            timeLabel.text = "1 Hour Ago"
        } else if offsetHours == 1 {
            timeLabel.text = "In 1 Hour"
        } else if offsetHours > 1 {
            timeLabel.text = "In \(offsetHours) Hours"
        } else {
            timeLabel.text = "Right Now"
        }
    }
    
    private func calculateBloodAlcoholContent() -> BloodAlcoholContent {
        if let drinkerInformation = DrinkerInformationManager.default.drinkerInformation {
            let safeMode = PreferenceManager.default.safeMode
            let measureDate = Date().addingTimeInterval(offsetTimeInterval)
            let measureDrinks = DrinkManager.default.drinks
            let alcoholCalculator = AlcoholCalculator(drinkerInformation: drinkerInformation, safeMode: safeMode)
            let bloodAlcoholContent = alcoholCalculator.bloodAlcoholContent(atDate: measureDate, afterDrinks: measureDrinks)
            os_log("BAC was recalculated to be %f. Measure date: %@, safe mode: %@.", bloodAlcoholContent, measureDate.description, safeMode.description)
            return bloodAlcoholContent
        } else {
            os_log("BAC could not be calculated because drinker information is not avaliable. A default value of 0.00 will be used instead.")
            return BloodAlcoholContent(0.00)
        }
    }
    
    private func format(bloodAlcoholContent: BloodAlcoholContent) -> String? {
        bloodAlcoholContentNumberFormatter.numberStyle = .decimal
        bloodAlcoholContentNumberFormatter.minimumFractionDigits = 2
        bloodAlcoholContentNumberFormatter.maximumFractionDigits = 2
        bloodAlcoholContentNumberFormatter.maximumIntegerDigits = 2
        return bloodAlcoholContentNumberFormatter.string(from: NSNumber(value: bloodAlcoholContent))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThemeNavigationViewController {
            destination.themeColor = ThemeAgent.themeColor(forBAC: latestBloodAlcoholContentTheme)
        }
    }
    
}
