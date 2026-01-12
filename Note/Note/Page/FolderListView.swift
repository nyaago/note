//
//  FolderListView.swift
//  Note
//
//  Created by nyaago on 2026/01/12.
//

import SwiftUI
import SwiftData

struct FolderItemView: View {
    let folder: Folder
    
    var body: some View {
        HStack(alignment: .center) {
            Text(folder.name)
                .modifier(ListItemContentModifier())
        }.modifier(ListItemViewModifier())
    }
}

struct AllItemsView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            Text("All Items")
                .modifier(ListItemContentModifier())
        }.modifier(ListItemViewModifier())
    }
}

struct FolderListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.navigationRouter) private var navigationRouter
    
    @State private var creatingFolder = false
    
    @Query private var folders: [Folder]


    var body: some View {
        List {
            NavigationLink(value: AllNotesFolder(), label: {
                AllItemsView()
            })
            ForEach(folders) { folder in
                NavigationLink(value :folder, label: {
                    FolderItemView(folder: folder)
                })
            }
        }
        .navigationTitle("Folders")
        .navigationDestination(for: Folder.self, destination: { folder in
            NoteListView(folder: folder)
        })
        .navigationDestination(for: AllNotesFolder.self, destination: { folder in
            NoteListView(folder: nil)
        })
    }
}

#Preview {
    FolderListView()
        .modelContainer(SampleFolder.previewContainer)
}
