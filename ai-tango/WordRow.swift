//
//  WordRow.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI

struct WordRow: View {
    let word: Word
    
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
    WordRow(word: SampleData.shared.word)
}
