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
class HomeViewController: UIViewController, CalculationDelegate {
    
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
    
    private var needsUpdate: Bool = false
    private var recalculationTimer: Timer?
    
    private var themeColor: ThemeColor!
    
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
        
        needsUpdate = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if DrinkerInformationManager.default.drinkerInformation == nil {
            DrinkerInformationManager.default.update(drinkerInformation: DrinkerInformation(weight: Measurement(value: 200, unit: UnitMass.pounds), sex: .male, alcoholMetabolism: .average))
            performSegue(withIdentifier: "showSettings", sender: self)
        }
        
        if needsUpdate {
            updateTimeLabel(animated: true)
            updateMeasurement(animated: true)
        }
        
        startRecalculationTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        needsUpdate = false
        
        stopRecalculationTImer()
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
    
    func calculationVariableDidChange() {
        needsUpdate = true
    }
    
    /// Update the on-screen measurement.
    ///
    /// - Parameter animated: If `true`, updates to the time label will be animated.
    func updateMeasurement(animated: Bool) {
        let bloodAlcoholContent = calculateBloodAlcoholContent()
        let bloodAlcoholContentFormatted = format(bloodAlcoholContent: bloodAlcoholContent)!
        themeColor = ThemeAgent.themeColor(forBAC: Double(bloodAlcoholContentFormatted)!)
        let updateFunction = {
            // Update the BAC label
            self.bloodAlcoholContentLabel.text = bloodAlcoholContentFormatted
            // Update the background color to match the label
            self.view.backgroundColor = self.themeColor.normal
        }
        if animated {
            UIView.animate(withDuration: 0.50, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: updateFunction, completion: nil)
        } else {
            updateFunction()
        }
    }
    
    /// Update the on-screen time label.
    ///
    /// - Parameter animated: If `true`, updates to the time label will be animated.
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
        if let drinks = DrinkManager.default.drinks, let drinkerInformation = DrinkerInformationManager.default.drinkerInformation {
            let safeMode = SafeModeManager.default.safeMode
            let measureDate = Date().addingTimeInterval(offsetTimeInterval)
            let alcoholCalculator = AlcoholCalculator(drinkerInformation: drinkerInformation, safeMode: safeMode)
            let bloodAlcoholContent = alcoholCalculator.bloodAlcoholContent(atDate: measureDate, afterDrinks: drinks)
            os_log("BAC was calculated to be %f at %@ with safe mode %@.", bloodAlcoholContent, measureDate.description, safeMode.description)
            return bloodAlcoholContent
        } else {
            os_log("BAC could not be calculated because there is not enough information avaliable. A default value of 0.00 will be used.")
            return BloodAlcoholContent(0.00)
        }
    }
    
    private func format(bloodAlcoholContent: BloodAlcoholContent) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.maximumIntegerDigits = 2
        return numberFormatter.string(from: NSNumber(value: bloodAlcoholContent))
    }
    
    private func startRecalculationTimer() {
        recalculationTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { (timer) in
            self.updateMeasurement(animated: true)
        })
    }
    
    private func stopRecalculationTImer() {
        recalculationTimer?.invalidate()
        recalculationTimer = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThemeNavigationViewController {
            destination.themeColor = themeColor
        }
        // TODO: Clean up how the calculationDelegate is linked.
        if let destination = (segue.destination as? UINavigationController)?.topViewController as? AddDrinkTableViewController {
            destination.calculationDelegate = self
        }
        if let destination = (segue.destination as? UINavigationController)?.topViewController as? HistoryTableViewController {
            destination.calculationDelegate = self
        }
        if let destination = (segue.destination as? UINavigationController)?.topViewController as? SettingsMasterTableViewController {
            destination.calculationDelegate = self
        }
    }
    
}
