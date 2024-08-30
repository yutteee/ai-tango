//
//  AddWord.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/09.
//

import SwiftUI
import OpenAI

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
                    Task {
                        await fetchOpenAIResponse()
                    }
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
    
    private func fetchOpenAIResponse() async {
        let openAIApiKey = APIKeyManager.shared.apiKey(for: "OPENAI_API_KEY")
        
        if let openAIApiKey = openAIApiKey {
            let openAI = OpenAI(apiToken: openAIApiKey)
            guard let systemMessage = ChatQuery.ChatCompletionMessageParam(role: .assistant, content: "あなたは与えられた英単語とその意味を基に、適切な例文を作成してください。出力は次の形式のJSONで行ってください。```{'example_english': 'She is quick to understand complex concepts.','example_japanese': '彼女は複雑な概念を理解するのが早い。'}```") else { return }
            guard let userMessage = ChatQuery.ChatCompletionMessageParam(role: .user, content: "\(word.english) \(word.japanese)") else { return }
            let query = ChatQuery(messages: [systemMessage, userMessage], model: .gpt4_o, responseFormat: .jsonObject)
            
            do {
                let result = try await openAI.chats(query: query)
                if let firstChoice = result.choices.first {
                    switch firstChoice.message {
                    case .assistant(let assistantMessage):
                        print(assistantMessage.content ?? "")
                        if let content = assistantMessage.content {
                            let data = content.data(using: .utf8)!
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
                            word.example_english = json["example_english"]!
                            word.example_japanese = json["example_japanese"]!
                        }
                    default:
                        break
                    }
                }
            } catch {
                print(error)
            }
        } else {
            print("APIキーが見つかりません")
        }
    }
}

#Preview {
    NavigationStack {
        AddWord(word: SampleData.shared.word)
            .navigationBarTitleDisplayMode(.inline)
    }
}
