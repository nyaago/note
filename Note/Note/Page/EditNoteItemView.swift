//
//  NewNoteItemView.swift
//  Note
//
//  Created by nyaago on 2026/01/03.
//

import SwiftUI

struct EditNoteItemView: View {
    private var note: Note?
    @State var content: String
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var savedAt: Date?

    init(note: Note) {
        self.note = note
        self.content = note.content
        self.savedAt = Date()
    }
    
    // preview 用
    init(content: String) {
        self.content = content
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
            })
    }
    
    private var doneToolbarContent: some ToolbarContent {
        let text: String = "Done"
        return ToolbarItem(placement: .navigationBarLeading) {
            Button(text, action: {
                changeNoteContentAndDismiss()
            })
        }
    }
    
    private func changeNoteContent() {
        guard let note = self.note else {
            return
        }
        note.content = content
        note.timestamp = Date()
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
    
    private func changeNoteContentAndDismiss() {
        changeNoteContent()
        dismiss()
    }
}

#Preview {
    EditNoteItemView(content: "New Content")
}
