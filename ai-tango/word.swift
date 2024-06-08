//
//  word.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import Foundation

struct Word:Codable, Identifiable{
    let id: Int
    let english: String
    let japanese: String
    let example_english: String
    let example_japanese: String
}
