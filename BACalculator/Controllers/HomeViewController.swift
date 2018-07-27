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
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var historyButton: UIBarButtonItem!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var advanceButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bloodAlcoholContentLabel: UILabel!
    
    private var bloodAlcoholContentAgent: BloodAlcoholContentAgent = BloodAlcoholContentAgent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateMeasurement(animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Update the simulated time.
    func updateTime() {
        updateTimeLabel()
        updateMeasurement(animated: true)
    }
    
    /// Update the BAC measurement.
    ///
    /// - Parameter animated: If `true`, updates to on-screen measurements will be animated.
    func updateMeasurement(animated: Bool) {
        let bloodAlcoholContent = bloodAlcoholContentAgent.calculateBAC(safeMode: PreferencesManager.safeMode)
        updateBloodAlcoholContentLabel(withBAC: bloodAlcoholContent, animated: animated)
        updateBackgroundColor(forBAC: bloodAlcoholContent, animated: animated)
    }
    
    /// Recalculate BAC using `hoursOffset`, `DrinkerInformationManager`, and `DrinkManager`.
    ///
    /// - Parameter measureDate: The `Date` to measure BAC at.
    /// - Returns: `BloodAlcoholContent` measurement at the specified `Date`.
    private func calculateBAC(atDate measureDate: Date) -> BloodAlcoholContent {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: DrinkerInformationManager.drinkerInformation)
        let bloodAlcoholContent = alcoholCalculator.bloodAlcoholContent(atDate: measureDate, afterDrinks: DrinkManager.drinks)
        os_log("Calculated BAC to be %f at %@.", bloodAlcoholContent, measureDate.description)
        return bloodAlcoholContent
    }
    
    /// Update the on-screen BAC label with a formatted version of the calculated BAC.
    ///
    /// - Parameters:
    ///   - bloodAlcoholContent: The `BloodAlcoholContent` to format and display on-screen.
    ///   - animated: If `true`, an update to the BAC label will be animated.
    private func updateBloodAlcoholContentLabel(withBAC bloodAlcoholContent: BloodAlcoholContent, animated: Bool) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        bloodAlcoholContentLabel.text = numberFormatter.string(from: NSNumber(value: bloodAlcoholContent))
    }
    
    /// Update the background color with a color matching the calculated BAC.
    ///
    /// - Parameters:
    ///   - bloodAlcoholContent: The `BloodAlcoholContent` to use for picking a background color.
    ///   - animated: If `true`, an update to the background color will be animated.
    private func updateBackgroundColor(forBAC bloodAlcoholContent: BloodAlcoholContent, animated: Bool) {
        let newBackgroundColor = ColorManager.themeColor(forBAC: bloodAlcoholContent)
        let updateBackgroundColor = {
            self.view.backgroundColor = newBackgroundColor.normal
        }
        if animated {
            let animationDuration: TimeInterval = 0.50
            let animationDelay: TimeInterval = 0.0
            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: [.allowUserInteraction, .beginFromCurrentState], animations: updateBackgroundColor, completion: nil)
        } else {
            updateBackgroundColor()
        }
    }
    
    /// Update the time label with the proper number of hours offset.
    private func updateTimeLabel() {
        if bloodAlcoholContentAgent.offsetHours < -1 {
            timeLabel.text = "\(abs(bloodAlcoholContentAgent.offsetHours)) Hours Ago"
        } else if bloodAlcoholContentAgent.offsetHours == -1 {
            timeLabel.text = "1 Hour Ago"
        } else if bloodAlcoholContentAgent.offsetHours > 1 {
            timeLabel.text = "In \(bloodAlcoholContentAgent.offsetHours) Hours"
        } else if bloodAlcoholContentAgent.offsetHours == 1 {
            timeLabel.text = "In 1 Hour"
        } else {
            timeLabel.text = "Right Now"
        }
    }
    
    @IBAction func timeControlPressed(_ sender: TimeControlButton) {
        bloodAlcoholContentAgent.adjustOffset(byHours: sender.stepSizeHours)
        updateTime()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BloodAlcoholContentNavigationViewController {
            destination.cachedBloodAlcoholContent = bloodAlcoholContentAgent.calculateBAC(safeMode: PreferencesManager.safeMode)
        }
    }
    
}
