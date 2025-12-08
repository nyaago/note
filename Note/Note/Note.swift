//
//  Item.swift
//  Note
//
//  Created by nyaago on 2025/12/04.
//

import Foundation
import SwiftData

@Model
final class Note {
    private(set) var uuid = UUID()
    private(set) var createdAt: Date
    private(set) var timestamp: Date
    var content: String = ""
    
    init(content: String) {
        self.timestamp = Date()
        self.createdAt = Date()
        self.content = content
    }
}
