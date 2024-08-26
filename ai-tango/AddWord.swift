//
//  AddWord.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/09.
//

import SwiftUI

struct AddWord: View {
    @Bindable var word : Word
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(word: Word) {
        self.word = word
    }

    var body: some View {
        Form {
            TextField("英語", text: $word.english)
            TextField("日本語", text: $word.japanese)
        }
        .navigationTitle("単語を追加")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    modelContext.delete(word)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddWord(word: SampleData.shared.word)
            .navigationBarTitleDisplayMode(.inline)
    }
}
