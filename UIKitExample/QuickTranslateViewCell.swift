//
//  QuickTranslateViewCell.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 03/04/24.
//

import UIKit

class QuickTranslateViewCell: UITableViewCell {
    @IBOutlet var sentenceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code.
        // Shows the disclosure indicator in the row.
        self.accessoryType = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state.
    }
    
    // Updates the lables and the image.
    func update(with sentence: Sentence) {
        sentenceLabel.text = sentence.sentence
    }
}
