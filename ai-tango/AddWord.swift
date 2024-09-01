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
    
    @State private var isEnglishValid = true
    @State private var isJapaneseValid = true
    
    @State private var isFormValid = false
    @State private var isFormEmpty = true
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var isLoading = false

    init(word: Word) {
        self.word = word
    }
    
    var body: some View {
        Form {
            Section(header: Text("英語").padding(0.0), footer: Text(!isValidEnglish(word.english) ? "アルファベットのみ入力可能です。" : "")
                .font(.body)
                .foregroundColor(.red)
            ) {
                TextField("English", text: $word.english)
                    .onChange(of: word.english) { newValue in
                        isEnglishValid = isValidEnglish(newValue)
                        isFormEmpty = word.english.isEmpty || word.japanese.isEmpty
                    }
                    .autocapitalization(.none) // 最初の文字を大文字にしない
                    .keyboardType(.asciiCapable) // 英数字のみ
                    .padding(.vertical, 6.0)
            }
            Section(header: Text("日本語").padding(.top, -12), footer: Text(!isValidJapanese(word.japanese) ? "ひらがな、カタカナ、漢字のみ入力可能です。" : "")
                .font(.body)
                .foregroundColor(.red)
            ) {
                TextField("日本語", text: $word.japanese)
                    .onChange(of: word.japanese) { newValue in
                        isJapaneseValid = isValidJapanese(newValue)
                        isFormEmpty = word.english.isEmpty || word.japanese.isEmpty
                    }
                    .keyboardType(.default)
                    .padding(.vertical, 6.0)
            }
            
            if isLoading {
                Section(footer: ProgressView()
                    .background(Color.clear)
                    .frame(maxWidth: .infinity, alignment: .center)) {}
            }
            
            if isFormValid && isFormEmpty {
                Section(footer: Text("英語と日本語を入力してください。")
                    .font(.body)
                    .foregroundColor(.red)) {}
                    .padding(.top, -24.0)
                    
            }
        }
        .navigationTitle("単語を追加")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    if !word.english.isEmpty && !word.japanese.isEmpty {
                        Task {
                            do {
                                isLoading = true
                                try await fetchOpenAIResponse()
                                modelContext.insert(word)
                                dismiss()
                            } catch {
                                isLoading = false
                                showErrorAlert = true
                                errorMessage = "文章の生成に失敗しました。時間をおいて再度お試しいただくか、単語を変えてお試しください。 " + error.localizedDescription
                            }
                        }
                    } else {
                        isFormValid = true
                    }
                }
                .disabled(isLoading || !isEnglishValid || !isJapaneseValid || isFormValid && isFormEmpty)
            }
            
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    modelContext.delete(word)
                    dismiss()
                }
                .disabled(isLoading)
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("エラー"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // 英語のバリデーション
    func isValidEnglish(_ input: String) -> Bool {
//      アルファベットと空白を許可する
        let regex = "^[a-zA-Z ]*$"
        return input.range(of: regex, options: .regularExpression) != nil
    }

    // 日本語のバリデーション
    func isValidJapanese(_ input: String) -> Bool {
        let regex = "^[\\p{Hiragana}\\p{Katakana}\\p{Han}]*$"
        return input.range(of: regex, options: .regularExpression) != nil
    }
    
    private func fetchOpenAIResponse() async throws {
        let openAIApiKey = APIKeyManager.shared.apiKey(for: "OPENAI_API_KEY")
        
        if let openAIApiKey = openAIApiKey {
            let openAI = OpenAI(apiToken: openAIApiKey)
            guard let systemMessage = ChatQuery.ChatCompletionMessageParam(role: .assistant, content: "あなたは与えられた英単語とその意味を基に、適切な例文を作成してください。出力は次の形式のJSONで行ってください。```{'example_english': 'She is quick to understand complex concepts.','example_japanese': '彼女は複雑な概念を理解するのが早い。'}```") else { return }
            guard let userMessage = ChatQuery.ChatCompletionMessageParam(role: .user, content: "\(word.english) \(word.japanese)") else { return }
            let query = ChatQuery(messages: [systemMessage, userMessage], model: .gpt3_5Turbo, responseFormat: .jsonObject)
            
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
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "APIリクエストに失敗しました: \(error.localizedDescription)"])
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
