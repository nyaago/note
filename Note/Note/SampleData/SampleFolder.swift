//
//  SampleFolder.swift
//  Note
//
//  Created by nyaago on 2026/01/12.
//

import SwiftData

@MainActor
class SampleFolder {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(
                for: Folder.self,
                configurations: config
            )
            for i in 0..<10 {
                var folder = Folder(name: "folder \(i+1) ")
                container.mainContext.insert(folder)
            }
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
