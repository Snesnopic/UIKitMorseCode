//
//  EncodeViewController.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 22/03/24.
//

import UIKit

class EncodeViewController: UIViewController {
    @IBOutlet var morseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Encode"
    }
    
    @IBAction func textLabelEditingChanged(_ sender: UITextField) {
        morseLabel.text = sender.text
    }
}

