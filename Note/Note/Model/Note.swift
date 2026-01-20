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
    var uuid = UUID()
    var createdAt: Date = Date()
    var timestamp: Date = Date()
    var content: String = ""
    var folder: Folder?
    
    init(content: String, folder: Folder?) {
        self.timestamp = Date()
        self.createdAt = Date()
        self.content = content
        self.folder = folder
    }
    
    var formatedTimestamp: String {
        get {
            let now = Date()
            let elapsedDays = Calendar.current.dateComponents([.day], from: timestamp, to: now).day!
            if elapsedDays > 7 {
                return formatDate(date: timestamp)
            }
            else {
                return formatRelativeDate(date: timestamp)
            }
        }
    }
    
    func updateFolderTimestamp() {
        if let folder = self.folder {
            folder.timestamp = Date()
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func formatRelativeDate(date: Date) -> String {
        var formatStyle = Date.RelativeFormatStyle()
        let now = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: date, to: now).day!
        if elapsedDays > 2 {
            formatStyle.presentation = .numeric
        }
        else {
            formatStyle.presentation = .named
        }
        formatStyle.unitsStyle = .spellOut
        return formatStyle.format(date)
    }

    var isEmpty: Bool {
        content.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    static func predicateForfilteingByFolder(folder: Folder?) -> Predicate<Note> {
        if let unwrappedFolder = folder {
            let uuid = unwrappedFolder.uuid
            return #Predicate<Note> { note in
                note.folder?.uuid == uuid
            }
        }
        else {
            return #Predicate<Note> { note in
                true
            }
        }
    }
    
    static func defaultSortDescriptors() -> [SortDescriptor<Note>] {
        [SortDescriptor(\.timestamp, order: .reverse)]
    }
}
