//
//  Converter.swift
//  Discord Letters
//
//  Created by Guðmundur Halldórsson on 26/01/2018.
//  Copyright © 2018 Guðmundur Halldórsson. All rights reserved.
//

import Foundation


class Converter{
    
    private let numbers: [Int: String]
    private let alphabet: [String]
    public var text: String
    
    init()
    {
        self.numbers = [0: ":zero:", 1: ":one:", 2: ":two:", 3: ":three:", 4: ":four:", 5: ":five:", 6: ":six:",
                        7: ":seven:", 8: ":eight:", 9: ":nine:", 10: ":ten:"]
        self.alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
                         "s", "t", "u", "v", "w", "x", "y", "z"]
        self.text = ""
    }
    
    init(text: String)
    {
        self.numbers = [0: ":zero:", 1: ":one:", 2: ":two:", 3: ":three:", 4: ":four:", 5: ":five:", 6: ":six:",
                        7: ":seven:", 8: ":eight:", 9: ":nine:", 10: ":ten:"]
        self.alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
                         "s", "t", "u", "v", "w", "x", "y", "z"]
        self.text = text
    }
    
    func convert() -> String
    {
        var letter_string = ""
        for char_index in self.text.characters.indices {
            if let number = Int(String(self.text[char_index])) {
                letter_string.append(self.numbers[number]! + " ")
            }
            else if self.alphabet.contains(String(self.text[char_index]).lowercased()) {
                letter_string.append(":regional_indicator_\(String(self.text[char_index]).lowercased()): ")
            }
            else if self.text[char_index] == " " {
                letter_string.append("      ")
            }
        }
        return letter_string
    }
    
}
