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

    private func addNote() {
        withAnimation {
            let newItem = Note(content: "dummy")
            modelContext.insert(newItem)
        }
    }

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

private extension ContentView {
    
}

#Preview {
    ContentView()
        .modelContainer(SampleNote.previewContainer)
}
