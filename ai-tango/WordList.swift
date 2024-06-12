//
//  WordList.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI

struct WordList: View {
    @State private var words: [Word] = [
        Word(id: 1, english: "apple", japanese: "りんご", example_english: "This is an apple", example_japanese: "これはりんごです"),
        Word(id: 2, english: "banana", japanese: "バナナ", example_english: "This is a banana", example_japanese: "これはバナナです")
    ]
    
    @State private var isShowSheet = false
    
    
    var body: some View {
        NavigationSplitView {
            List(words) { word in
                NavigationLink {
                    WordDetail(word: word)
                } label: {
                    WordRow(word: word)
                }
            }
            .navigationTitle("単語一覧")
            
//            ボタンを押したらaddWordがハーフモーダルで表示される
            Button(action: {
                isShowSheet.toggle()
            }) {
                Label("単語を追加", systemImage: "plus")
                    .font(.headline)
            }
            .sheet(isPresented: $isShowSheet) {
                AddWord()
                    .presentationDetents([
                        .medium,
                        .large
                    ])
            }
            
            
            
        } detail : {
            Text("単語を選択")
        }
    }
}

#Preview {
    WordList()
}
