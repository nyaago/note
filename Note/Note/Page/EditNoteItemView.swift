//
//  NewNoteItemView.swift
//  Note
//
//  Created by nyaago on 2026/01/03.
//

import SwiftUI

struct EditNoteItemView: View {
    private var note: Note
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State var content: String
    @State private var savedAt: Date?
    @State private var isShowMoveFolderSheetView = false

    init(note: Note) {
        self.note = note
        self.content = note.content
        self.savedAt = Date()
    }
    
    // preview 用
    init(content: String) {
        self.content = content
        self.note = Note(content: "Hellow World!", folder: nil)
    }

    init() {
        self.init(content: "")
    }

    var body: some View {
        TextEditor(text: $content)
            .scrollContentBackground(Visibility.hidden)
            .modifier(TextEditorModifier())
            .onAppear() {
            }
            .onChange(of: content) {
                changeNoteContentIfNeed()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                doneToolbarContent
                menuToolbarContent
            })
            .sheet(isPresented: $isShowMoveFolderSheetView) {
                    
            } content: {
                MoveNoteSheetView(note: self.note)
            }
    }
    
    private var doneToolbarContent: some ToolbarContent {
        let text: String = "Done"
        return ToolbarItem(placement: .navigationBarLeading) {
            Button(text, action: {
                changeNoteContentAndDismiss()
            })
        }
    }
    
    private var menuToolbarContent: some ToolbarContent {
        return ToolbarItem(placement: .navigationBarTrailing) {
            menu
        }

    }
    
    private func changeNoteContent() {
        note.content = content
        note.timestamp = Date()
        note.updateFolderTimestamp()
        self.savedAt = Date()
    }
    
    private func changeNoteContentIfNeed() {
        let timeIntervalToAdd: TimeInterval = 30
        guard let savedAt = self.savedAt else {
            return
        }
        if Date().timeIntervalSince(savedAt) > timeIntervalToAdd {
            changeNoteContent()
        }
    }
    
    private func deleteContent() {
        self.modelContext.delete(note)
    }
    
    private var isEmpty: Bool {
        return note.isEmpty
    }
    
    private func changeNoteContentAndDismiss() {
        changeNoteContent()
        if isEmpty {
            deleteContent()
        }
        dismiss()
    }
    
    private var menu : some View {
        Menu {
            Button(
                action: {
                    isShowMoveFolderSheetView = true
                },
                label: {
                    MenuItemLabel(systemImage: "folder", text: "Move")
                }
            )
            Button(
                action: {
                    deleteContent()
                    dismiss()
                },
                label: {
                    MenuItemLabel(systemImage: "trash", text: "Delete")
                }
            )
            } label: {
                Image(systemName: "ellipsis")
            }
    }
}

#Preview {
    EditNoteItemView(content: "New Content")
}
