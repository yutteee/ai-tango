//
//  WordDetail.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI
import SwiftData

struct WordDetail: View {
    var word : Word
    
    var body: some View {
        VStack(spacing: 24.0) {
            VStack(alignment: .center, spacing: 16.0) {
                Text(word.english)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(word.japanese)
                    .font(.title)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16.0) {
                Text("例文")
                    .foregroundColor(Color.gray)
                
                VStack(alignment: .leading, spacing: 12.0) {
                    Text(word.example_english)
                        .font(.title2)
                    Text(word.example_japanese)
                        .font(.title2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(24.0)
        
        
    }
}

#Preview {
    WordDetail(word: SampleData.shared.word)
}
