//
//  ContentView.swift
//  Note
//
//  Created by nyaago on 2025/12/04.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]

    var body: some View {
        NavigationSplitView {
            NoteListView()
        } detail: {
            Text("Select an item")
        }
    }
}

private extension ContentView {
    
}

#Preview {
    ContentView()
        .modelContainer(SampleNote.previewContainer)
}
