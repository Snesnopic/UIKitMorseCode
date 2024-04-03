//
//  VibrationEngine.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 03/04/24.
//

import Foundation
import CoreHaptics
import AVFAudio
import UIKit

class VibrationEngine {
    static let shared:VibrationEngine = VibrationEngine()
    private init() {
        
    }
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine?
    
    // configurable time unit, will be changeable later with settings
    static let timeUnit = SettingsBundleHelper.getSliderPreference()
    
    let dotDuration: TimeInterval = 1 * timeUnit // Duration for a dot
    let dashDuration: TimeInterval = 3 * timeUnit // Duration for a dash
    let sameCharacterSeparatorDelay: TimeInterval = 1 * timeUnit // Delay between same characters
    let characterSeparatorDelay: TimeInterval = 3 * timeUnit // Delay between different characters
    let wordSeparatorDelay: TimeInterval = 7 * timeUnit // Delay for word separator
    
    var vibrationTimer: Timer?
    
    var morseCodeIndex = 0
    var morseCodeString = ""
    
    func readMorseCode(morseCode: String) {
        morseCodeIndex = 0
        morseCodeString = morseCode
        triggerNextVibration()
    }
    
    // Function to trigger vibrations based on Morse code
    func triggerNextVibration() {
        guard morseCodeIndex < morseCodeString.count else {
            // End of Morse code string
            return
        }
        
        let character = morseCodeString.charAt(morseCodeIndex)
        var nextCharacter: Character {
            if morseCodeIndex + 1 >= morseCodeString.count {
                return character
            }
            else {
                return morseCodeString.charAt(morseCodeIndex + 1)
            }
        }
        morseCodeIndex += 1
        
        switch character {
        case ".":
            playHapticsFile(named: "dot")
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: dotDuration + (character == nextCharacter ? sameCharacterSeparatorDelay : characterSeparatorDelay), repeats: false) { _ in
                self.triggerNextVibration()
            }
        case "-":
            for _ in 1...3 {
                playHapticsFile(named: "dash")
                usleep(UInt32(dashDuration) * (10000 * UInt32(VibrationEngine.timeUnit)))
            }
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: dashDuration + (character == nextCharacter ? sameCharacterSeparatorDelay : characterSeparatorDelay), repeats: false) { _ in
                self.triggerNextVibration()
            }
            
        case "/":
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: wordSeparatorDelay, repeats: false) { _ in
                self.triggerNextVibration()
            }
        default:
            // Ignore unrecognized characters
            break
        }
    }
    
    // Function to stop reading Morse code
    func stopReading() {
        vibrationTimer?.invalidate()
    }
    
    
    /// - Tag: CreateEngine
    func createEngine() {
        // Create and configure a haptic engine.
        do {
            // Associate the haptic engine with the default audio session
            // to ensure the correct behavior when playing audio-based haptics.
            let audioSession = AVAudioSession.sharedInstance()
            engine = try CHHapticEngine(audioSession: audioSession)
        } catch let error {
            print("Engine Creation Error: \(error)")
        }
        
        guard let engine = engine else {
            print("Failed to create engine!")
            return
        }
        
        // The stopped handler alerts you of engine stoppage due to external causes.
        engine.stoppedHandler = { reason in
            print("The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt:
                print("Audio session interrupt")
            case .applicationSuspended:
                print("Application suspended")
            case .idleTimeout:
                print("Idle timeout")
            case .systemError:
                print("System error")
            case .notifyWhenFinished:
                print("Playback finished")
            case .gameControllerDisconnect:
                print("Controller disconnected.")
            case .engineDestroyed:
                print("Engine destroyed.")
            @unknown default:
                print("Unknown error")
            }
        }
 
        // The reset handler provides an opportunity for your app to restart the engine in case of failure.
        engine.resetHandler = {
            // Try restarting the engine.
            print("The engine reset --> Restarting now!")
            do {
                try self.engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }
    }
    
    /// - Tag: PlayAHAP
    func playHapticsFile(named filename: String) {
        
        // If the device doesn't support Core Haptics, abort.
        if !supportsHaptics {
            return
        }
        
        // Express the path to the AHAP file before attempting to load it.
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {
            return
        }
        
        do {
            // Start the engine in case it's idle.
            try engine?.start()
            
            // Tell the engine to play a pattern.
            try engine?.playPattern(from: URL(fileURLWithPath: path))
            
        } catch { // Engine startup errors
            print("An error occured playing \(filename): \(error).")
        }
    }
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var supportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()
    
}
