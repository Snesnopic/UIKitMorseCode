//
//  SettingsBundleHelper.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 26/03/24.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let Slider = "slider_preference"
        static let Sound = "sound_enabled"
    }
   
    static func getSliderPreference() -> Double {
        print(Double(UserDefaults.standard.integer(forKey: SettingsBundleKeys.Slider)) / 10.0)
        return Double(UserDefaults.standard.integer(forKey: SettingsBundleKeys.Slider)) / 10.0
    }
    
    static func getSoundPreference() -> Bool {
        return UserDefaults.standard.bool(forKey: SettingsBundleKeys.Sound)
    }
    
}
