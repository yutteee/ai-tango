//
//  SampleData.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/12.
//

import Foundation
import SwiftData


@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            Word.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertSampleData() {
        for word in Word.sampleData {
            context.insert(word)
        }
        
        do {
            try context.save()
        } catch {
            fatalError("Could not save context: \(error)")
        }
    }
    
    var word: Word {
        Word.sampleData[0]
    }
    
    var words: [Word] {
        Word.sampleData
    }
}
