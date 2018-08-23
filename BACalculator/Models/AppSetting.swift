//
//  AppSetting.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

enum AppSetting {
    
    case weight
    case sex
    
    var title: String {
        switch self {
        case .weight:
            return "Weight"
        case .sex:
            return "Sex"
        }
    }
    var value: String? {
        switch self {
        case .weight:
            return DrinkerManager.default.drinker?.weight.description
        case .sex:
            return DrinkerManager.default.drinker?.sex.description.localizedCapitalized
        }
    }
    
    var showModifyInDetailViewController: Bool {
        switch self {
        case .weight:
            return true
        case .sex:
            return true
        }
    }
    var detailViewController: SettingsDetailTableViewController? {
        switch self {
        case .weight:
            return WeightSettingTableViewController()
        case .sex:
            return SexSettingTableViewController()
        }
    }
    
}
