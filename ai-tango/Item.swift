//
//  Item.swift
//  ai-tango
//
//  Created by 中村優作 on 2024/06/08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
