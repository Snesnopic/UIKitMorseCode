//
//  Sentence.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 26/03/24.
//

import Foundation

struct Sentence {
    var sentence:String
    var morseCode:String {
        return MorseEncoder.encode(string: sentence)
    }
    static var sampleData = [
        Sentence(sentence: "Yes, I can guide you."),
        Sentence(sentence: "I'm here to help."),
        Sentence(sentence: "I understand, let me assist you."),
        Sentence(sentence: "I'll write it down for you."),
        Sentence(sentence: "I'll describe the menu options for you."),
        Sentence(sentence: "I'll help you navigate through touch."),
        Sentence(sentence: "I'm communicating with you through touch."),
        Sentence(sentence: "I'll lead you to the bus stop."),
        Sentence(sentence: "Let me describe the location to you."),
        Sentence(sentence: "I'll tap your hand to get your attention.")
    ]
}
