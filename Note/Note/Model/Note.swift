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
        DateFormatUtil.formatDate(date: date)
    }
    
    func formatRelativeDate(date: Date) -> String {
        DateFormatUtil.formatRelativeDate(date: date)
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
    
    static func groupingNotes(notes: [Note]) -> Array<(key: Date, value: Array<Note>)> {
        let now = Date()
        let calendar = Calendar.current
        let recenyDays = 5
        
        let dict: Dictionary<Date, [Note]> = Dictionary<Date, [Note]>(grouping: notes) { note in
            let elapsedDays = calendar.dateComponents([.day], from: note.timestamp, to: now).day!
            if elapsedDays == 0 {
                let compornent = calendar.dateComponents([.year, .month, .day], from: now)
                return calendar.date(from: compornent)!
            }
            else if elapsedDays <= recenyDays {
                let day = calendar.date(byAdding: .day, value: -recenyDays, to: now)!
                let compornent = calendar.dateComponents([.year, .month, .day], from: day)
                return calendar.date(from: compornent)!
            }
            else {
                let date = note.timestamp
                let compornent = calendar.dateComponents([.year], from: date)
                return calendar.date(from: compornent)!
            }
        }
        let array = dict.sorted(by: {
            $0.key > $1.key
        } )
        return array
    }
}
