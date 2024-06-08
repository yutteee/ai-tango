//
//  WordRow.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI

struct WordRow: View {
    var word: Word
    
    var body: some View {
        HStack {
            Text(word.english)
            Spacer()
            Text(word.japanese)
        }
        .padding()
    }
}

#Preview {
    Group {
        WordRow(word: Word(id: 1, english: "apple", japanese: "りんご", example_english: "This is an apple", example_japanese: "これはりんごです"))
        WordRow(word: Word(id: 2, english: "banana", japanese: "バナナ", example_english: "This is a banana", example_japanese: "これはバナナです"))
    }
}
