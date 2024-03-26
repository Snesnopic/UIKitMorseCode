//
//  EncodeViewController.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 22/03/24.
//

import UIKit

class EncodeViewController: UIViewController {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    static let timeUnit = 0.1
    
    let dotDuration: TimeInterval = 1 * timeUnit // Duration for a dot
    let dashDuration: TimeInterval = 3 * timeUnit // Duration for a dash
    let sameCharacterSeparatorDelay: TimeInterval = 1 * timeUnit // Delay between same characters
    let characterSeparatorDelay: TimeInterval = 3 * timeUnit // Delay between different characters
    let wordSeparatorDelay: TimeInterval = 7 * timeUnit // Delay for word separator
    
    var vibrationTimer: Timer?
    var morseCodeIndex = 0
    var morseCodeString = ""
    @IBOutlet var morseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Encode"
    }
    
    @IBAction func textLabelEditingChanged(_ sender: UITextField) {
        morseLabel.text = MorseEncoder.encode(string: sender.text!)
    }
    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        readMorseCode(morseCode: morseLabel.text!)
        sender.isEnabled = true
    }
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
                return " "
            }
            else {
                return morseCodeString.charAt(morseCodeIndex + 1)
            }
        }
        morseCodeIndex += 1
        
        switch character {
        case ".":
            feedbackGenerator.impactOccurred(intensity: 0.7)
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: dotDuration, repeats: false) { _ in
                self.triggerNextVibration()
            }
        case "-":
            for _ in 1...3 {
                feedbackGenerator.impactOccurred(intensity: 1.0)
                usleep(UInt32(dashDuration) * 1000)
            }
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: dashDuration, repeats: false) { _ in
                self.triggerNextVibration()
            }
            
            
        case "/":
            feedbackGenerator.impactOccurred()
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: wordSeparatorDelay, repeats: false) { _ in
                self.triggerNextVibration()
            }
        default:
            // Ignore unrecognized characters
            break
        }
    }
    
    // Function to stop reading Morse code
    func stopReadingMorseCode() {
        vibrationTimer?.invalidate()
    }
    
    @IBAction func stopReading(_ sender: UIButton) {
        stopReadingMorseCode()
    }
}

