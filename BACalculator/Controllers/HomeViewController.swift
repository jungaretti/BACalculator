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
        updateMeasurement(animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Update the simulated time and update the BAC measurement to fit that time.
    func updateTime() {
        updateTimeLabel()
        updateMeasurement(animated: true)
    }
    
    /// Update the BAC measurement.
    ///
    /// - Parameter animated: If `true`, updates to on-screen measurements will be animated.
    func updateMeasurement(animated: Bool) {
        let bloodAlcoholContent = calculateBAC(atDate: Date().addingTimeInterval(timeIntervalOffset))
        updateBloodAlcoholContentLabel(withBAC: bloodAlcoholContent, animated: animated)
        updateBackgroundColor(forBAC: bloodAlcoholContent, animated: animated)
    }
    
    private func calculateBAC(atDate measureDate: Date) -> BloodAlcoholContent {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: DrinkerInformationManager.drinkerInformation)
        let bloodAlcoholContent = alcoholCalculator.bloodAlcoholContent(atDate: measureDate, afterDrinks: DrinkManager.drinks)
        os_log("Calculated BAC to be %f at %@.", bloodAlcoholContent, measureDate.description)
        return bloodAlcoholContent
    }
    
    private func updateBloodAlcoholContentLabel(withBAC bloodAlcoholContent: BloodAlcoholContent, animated: Bool) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        bloodAlcoholContentLabel.text = numberFormatter.string(from: NSNumber(value: bloodAlcoholContent))
    }
    
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
    
    @IBAction func timeControlPressed(_ sender: TimeControlButton) {
        hoursOffset += sender.hourStep
        updateTime()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThemedNavigationViewController {
            destination.bloodAlcoholContent = calculateBAC(atDate: Date().addingTimeInterval(timeIntervalOffset))
        }
    }
    
}
