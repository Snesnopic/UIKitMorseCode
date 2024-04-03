//
//  EncodeViewController.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 22/03/24.
//

import UIKit
import CoreHaptics
import AVFoundation

class EncodeViewController: UIViewController {
    let vibrationEngine: VibrationEngine = VibrationEngine.shared
    @IBOutlet var morseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Encode"
        vibrationEngine.createEngine()
    }
    
    // if you touch somewhere else, close the keyboard and remove focus from textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
    
    @IBAction func textLabelEditingChanged(_ sender: UITextField) {
        morseLabel.text = MorseEncoder.encode(string: sender.text!)
    }
    
    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        vibrationEngine.readMorseCode(morseCode: morseLabel.text!)
        sender.isEnabled = true
    }
    
}

