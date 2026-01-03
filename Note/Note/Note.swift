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
    
    var formatedTimestamp: String {
        get {
            formatDate(date: timestamp)
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

