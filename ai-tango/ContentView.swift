//
//  ContentView.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var words: [Word]
    var body: some View {
        WordList(words: words)
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Word.self, inMemory: true)
}
