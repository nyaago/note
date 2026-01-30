//
//  MoveNoteSheetView.swift
//  Note
//
//  Created by nyaago on 2026/01/29.
//

import SwiftUI
import SwiftData

struct MoveSheetItemView: View {
    let systemImage: String
    let folder: Folder
    
    init(folder: Folder) {
        self.folder = folder
        self.systemImage = "folder"
    }

    init(folder: Folder, systemImage: String) {
        self.folder = folder
        self.systemImage = systemImage
    }

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "folder")
                Text(folder.name)
            }.modifier(ListItemViewModifier())
        }
    }
}

struct MoveNoteSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.navigationRouter) private var navigationRouter
    @Environment(\.dismiss) private var dismiss
   
    let note: Note
    
    @Query private var folders: [Folder]

    init(note: Note) {
        let sortDescriptions = Folder.defaultSortDescriptors()
        _folders = Query(sort: sortDescriptions)
        self.note = note
    }

    var body: some View {
        List {
            ForEach(folders) { folder in
                MoveSheetItemView(folder: folder)
                .onTapGesture {
                    print("folder \(folder.name)")
                    moveNoteFolder(folder)
                    navigationRouter.path = NavigationPath()
                }
            }
        }
    }
    
    private func moveNoteFolder(_ folder: Folder) {
        note.folder = folder
    }
}

#Preview {
    MoveNoteSheetView(note: Note(content: "Hello, World!", folder: nil))
        .modelContainer(SampleFolder.previewContainer)
}
