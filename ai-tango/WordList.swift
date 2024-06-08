//
//  WordList.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI

struct WordList: View {
    var words: [Word] = [
        Word(id: 1, english: "apple", japanese: "りんご", example_english: "This is an apple", example_japanese: "これはりんごです"),
        Word(id: 2, english: "banana", japanese: "バナナ", example_english: "This is a banana", example_japanese: "これはバナナです")
    ]
    
    
    var body: some View {
        List(words) { word in
            WordRow(word: word)
        }
    }
}

#Preview {
    WordList()
}
