//
//  word.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import Foundation
import SwiftData

@Model
class Word {
    let english: String
    let japanese: String
    let example_english: String
    let example_japanese: String
    
    init(english: String, japanese: String, example_english: String, example_japanese: String) {
        self.english = english
        self.japanese = japanese
        self.example_english = example_english
        self.example_japanese = example_japanese
    }
    
    static let sampleData = [
        Word(english: "apple", japanese: "りんご", example_english: "This is an apple", example_japanese: "これはりんごです"),
        Word(english: "banana", japanese: "バナナ", example_english: "This is a banana", example_japanese: "これはバナナです"),
        Word(english: "grape", japanese: "ぶどう", example_english: "This is a grape", example_japanese: "これはぶどうです"),
    ]
}
