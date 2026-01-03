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

    init(note: Note) {
        self.note = note
        self.content = note.content
    }
    
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
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                doneToolbarContent
            })
    }
    
    private var doneToolbarContent: some ToolbarContent {
        let text: String = "Done"
        return ToolbarItem(placement: .navigationBarLeading) {
            Button(text, action: {
                guard let note = self.note else {
                    dismiss()
                    return
                }
                note.content = content
                dismiss()
            })
        }
    }
}

#Preview {
    EditNoteItemView(content: "New Content")
}
