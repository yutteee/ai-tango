//
//  AddWord.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/09.
//

import SwiftUI
import SwiftData

struct AddWord: View {
    @Environment(\.modelContext) var context
    
    @State private var english = ""
    @State private var japanese = ""
    
    var body: some View {
        HStack{
            Text("英語")
            TextField("英語", text: $english)
        }
        .padding()
        HStack {
            Text("日本語")
            TextField("日本語", text: $japanese)
        }
        .padding()
        
        Button(action: {
            context.insert(Word(english: english, japanese: japanese, example_english: "", example_japanese: ""))
        }) {
            Label("単語を追加", systemImage: "plus")
                .font(.headline)
        }
    }
}

#Preview {
    AddWord()
        .modelContainer(for: Word.self, inMemory: true)
}
