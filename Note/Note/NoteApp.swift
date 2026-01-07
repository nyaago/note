//
//  NoteApp.swift
//  Note
//
//  Created by nyaago on 2025/12/04.
//

import SwiftUI
import SwiftData

@main
struct NoteApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note.self,
            Folder.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
