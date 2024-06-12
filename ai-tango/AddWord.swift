//
//  AddWord.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/09.
//

import SwiftUI

struct AddWord: View {
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
            print("単語を追加")
        }) {
            Label("単語を追加", systemImage: "plus")
                .font(.headline)
        }
    }
}

#Preview {
    AddWord()
}
