//
//  AllNotesFolder.swift
//  Note
//
//  Created by nyaago on 2026/01/13.
//

import Foundation

class AllNotesFolder: Hashable {
    var uuid = UUID()
    
    static func == (lhs: AllNotesFolder, rhs: AllNotesFolder) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
