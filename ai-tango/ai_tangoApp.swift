//
//  ai_tangoApp.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import SwiftUI
import SwiftData

@main
struct ai_tangoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Word.self)
        }
    }
}
