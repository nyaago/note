//
//  Folder.swift
//  Note
//
//  Created by nyaago on 2026/01/07.
//

import Foundation
import SwiftData

@Model
final class Folder {
 
    var uuid = UUID()
    var createdAt: Date = Date()
    var timestamp: Date = Date()
    var name: String = ""
    @Relationship(deleteRule: .nullify, inverse: \Note.folder) var notes: [Note]?
    
    init(name: String) {
        self.timestamp = Date()
        self.createdAt = Date()
        self.name = name
        self.notes = []
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
