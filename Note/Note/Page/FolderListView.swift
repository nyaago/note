//
//  FolderListView.swift
//  Note
//
//  Created by nyaago on 2026/01/12.
//

import SwiftUI
import SwiftData

struct FolderEditItemView: View {
    let folder: Folder
    
    var body: some View {
        HStack(alignment: .center) {
            Text(folder.name)
                .modifier(ListItemContentModifier())
            Spacer()
            editMenu
        }.modifier(ListItemViewModifier())
    }
    
    private var editMenu : some View {
        Menu {
            Button(
                action: {
                    
                },
                label: {
                    MenuItemLabel(systemImage: "pencil", text: "Rename")
                }
            )
            Button(
                role: .destructive,
                action: {
                    
                },
                label: {
                    MenuItemLabel(systemImage: "trash", text: "Remove")
                }
            ).foregroundColor(.red)
            } label: {
                Image(systemName: "ellipsis")
            }
    }
}


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
    
    enum ListEditMode {
        case active
        case inactive
    }
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.navigationRouter) private var navigationRouter
    
    @State var editMode: ListEditMode = .inactive
    @State private var creatingFolder = false
    
    @Query private var folders: [Folder]

    init() {
        let sortDescriptions = Folder.defaultSortDescriptors()
        _folders = Query(sort: sortDescriptions)
    }

    var body: some View {
        List {
            NavigationLink(value: AllNotesFolder(), label: {
                AllItemsView()
            })
            ForEach(folders) { folder in
                if self.editMode == .active {
                    FolderEditItemView(folder: folder)
                }
                else {
                    NavigationLink(value :folder, label: {
                        FolderItemView(folder: folder)
                    })
                }
            }
            //.onDelete(perform: deleteFolders)
        }
        .toolbar {
            editToolbarContent
            addToolbarContent
        }
        .navigationTitle("Folders")
        .navigationDestination(for: Folder.self, destination: { folder in
            NoteListView(folder: folder)
        })
        .navigationDestination(for: AllNotesFolder.self, destination: { folder in
            NoteListView(folder: nil)
        })
        .navigationDestination(for: Note.self, destination:  { note in
            EditNoteItemView(note: note)
        })
        .navigationDestination(isPresented: $creatingFolder, destination: {
            NewFolderView()
        })
    }
    
    private func addNote() {
        withAnimation {
            let newItem = Note(content: "", folder: nil)
            modelContext.insert(newItem)
            navigationRouter.path.append(newItem)
        }
    }
    
    private func addFolder() {
        withAnimation {
            creatingFolder = true
        }
    }
    
    /*
    private func deleteFolders(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
            }
        }
    }
     */

    
    private var editToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if self.editMode == .active {
                Button(action: doneEditing) {
                    Label("Done", systemImage: "checkmark")
                        
                }
            }
            else {
                editMenu
            }
        }
    }
    
    private var addToolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            HStack()  {
                Button(action: addFolder) {
                    Label("Add Folder", systemImage: "folder.badge.plus")
                        
                }
                Button(action: addNote) {
                    Label("Add Item", systemImage: "square.and.pencil")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    private var editMenu : some View {
        Menu {
            Button(
                action: {
                    startEditing()
                },
                label: {
                    MenuItemLabel(text: "Edit Folders")
                }
            )
            } label: {
                Image(systemName: "ellipsis")
            }
    }

    private func startEditing() {
        editMode = .active
    }
    
    private func doneEditing() {
        editMode = .inactive
    }
}

#Preview {
    FolderListView()
        .modelContainer(SampleFolder.previewContainer)
}
