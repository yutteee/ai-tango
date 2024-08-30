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
    @State private var isShowSheet = false
    
    
    var body: some View {
        NavigationSplitView {
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
            modelContext.insert(newItem)
            newWord = newItem
        }
    }
}

#Preview {
    WordList()
        .modelContainer(SampleData.shared.modelContainer)
}
