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
            
            Button(action: {
                isShowSheet.toggle()
            }) {
                Label("単語を追加", systemImage: "plus")
                    .font(.headline)
            }
            .sheet(isPresented: $isShowSheet) {
                AddWord()
                    .presentationDetents([
                        .large
                    ])
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
}

#Preview {
    WordList()
        .modelContainer(SampleData.shared.modelContainer)
}
