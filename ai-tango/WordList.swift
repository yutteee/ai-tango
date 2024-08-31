//
//  WordList.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI
import SwiftData

struct WordList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var words: [Word]
    
    @State private var newWord: Word?
    @State private var showingSheet = false
    
    var body: some View {
        NavigationSplitView {
            Group {
                if !words.isEmpty {
                    List{
                        ForEach(words) { word in
                            NavigationLink {
                                WordDetail(word: word)
                            } label: {
                                WordRow(word: word)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                } else {
                    ContentUnavailableView {
                        Label("単語がありません", systemImage: "figure.core.training")
                    }
                }
            }
            .navigationTitle("単語一覧")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            
            Button(action: addWord) {
                Label("単語を追加", systemImage: "plus")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 40.0)
            }
            .sheet(item: $newWord) { item in
                NavigationStack {
                    AddWord(word: item)
                }
                .interactiveDismissDisabled()
            }
        } detail : {
            Text("単語を選択")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(words[index])
            }
        }
    }
    
    private func addWord() {
        withAnimation {
            let newItem = Word(english: "", japanese: "", example_english: "", example_japanese: "")
            newWord = newItem
        }
    }
}

#Preview {
    WordList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
    WordList()
        .modelContainer(for: Word.self)
}
