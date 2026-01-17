//
//  NoteListView.swift
//  Note
//
//  Created by nyaago on 2025/12/08.
//

import SwiftUI
import SwiftData

struct NoteItemView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.content)
                .modifier(ListItemContentModifier())
            Text(note.formatedTimestamp)
                .modifier(ListItemNoteModifier())
        }
        .modifier(ListItemViewModifier())
    }
}

struct NoteListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.navigationRouter) private var navigationRouter
    
    @State private var creatingFolder = false
    
    @Query private var notes: [Note]
    
    private var folder: Folder?
    
    init() {
        self.init(folder: nil)
    }
    
    init(folder: Folder?) {
        self.folder = folder
        if let unwrappedFolder = folder {
            let uuid = unwrappedFolder.uuid
            let predicate = #Predicate<Note> { $0.folder?.uuid == uuid }
            _notes = Query(filter: predicate, sort: \Note.timestamp, order: .reverse)
        }
        else {
            _notes = Query(sort: \Note.timestamp, order: .reverse)
        }
    }
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NavigationLink(value :note, label: {
                    NoteItemView(note: note)
                })
            }
            .onDelete(perform: deleteNotes)
        }
        .toolbar {
            editToolbarContent
            addToolbarContent
        }
        .navigationDestination(for: Note.self, destination:  { note in
            EditNoteItemView(note: note)
        })
        .navigationDestination(isPresented: $creatingFolder, destination: {
            NewFolderView()
        })

    }
    private func addNote() {
        withAnimation {
            let newItem = Note(content: "", folder: folder)
            modelContext.insert(newItem)
            navigationRouter.path.append(newItem)
        }
    }
    
    private func addFolder() {
        withAnimation {
            creatingFolder = true
        }
    }
    
    private func doNothing() {
        
    }

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
    
    private var editToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
        }
    }
    
    private var addToolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            HStack()  {
                Button(action: doNothing) {
                 }
                Button(action: addNote) {
                    Label("Add Item", systemImage: "square.and.pencil")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    NoteListView()
        .modelContainer(SampleNote.previewContainer)}
