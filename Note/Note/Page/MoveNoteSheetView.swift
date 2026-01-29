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
   
    @Query private var folders: [Folder]

    init() {
        let sortDescriptions = Folder.defaultSortDescriptors()
        _folders = Query(sort: sortDescriptions)
    }

    var body: some View {
        List {
            ForEach(folders) { folder in
                MoveSheetItemView(folder: folder)
                .onTapGesture {
                    print("folder \(folder.name)")
                    navigationRouter.path = NavigationPath()
                }
            }
        }
    }
}

#Preview {
    MoveNoteSheetView()
        .modelContainer(SampleFolder.previewContainer)
}
