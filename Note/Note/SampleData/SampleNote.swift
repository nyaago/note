//
//  SampleNote.swift
//  Note
//
//  Created by nyaago on 2025/12/08.
//

import SwiftData

@MainActor
class SampleNote {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(
                for: Note.self,
                configurations: config
            )
            for i in 0..<10 {
                var note = Note(content: "note content \(i+1) ")
                container.mainContext.insert(note)
            }
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
