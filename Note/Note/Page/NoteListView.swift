//
//  NoteListView.swift
//  Note
//
//  Created by nyaago on 2025/12/08.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NavigationLink {
                    Text("Item at \(note.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                } label: {
                    Text(note.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .onDelete(perform: deleteNotes)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addNote) {
                    Label("Add Item", systemImage: "plus")
                }
            }
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

#Preview {
    NoteListView()
        .modelContainer(SampleNote.previewContainer)}
