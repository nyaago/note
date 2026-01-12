//
//  NewFolderView.swift
//  Note
//
//  Created by nyaago on 2026/01/11.
//

import SwiftUI

struct NewFolderView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State var name: String = ""
    @State var isShowAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form() {
                TextField("name", text: $name)
                    .modifier(TextFieldModifier())
            }
        }
        .toolbar {
            cancelToolbarContent
            doneToolbarContent
        }
        .navigationTitle(Text("Folder"))
        .navigationBarBackButtonHidden(true)
    }
    
    private func addFolder() {
        withAnimation {
            let newFolder = Folder(name: name)
            modelContext.insert(newFolder)
        }
    }
    
    private func onDone() {
        if !canDone {
            isShowAlert = true
            return
        }
        addFolder()
        dismiss()
    }
    
    private func onCancel() {
        dismiss()
    }
    
    private var doneToolbarContent: some ToolbarContent {
        let title = "Please input folder name"
        let message = "Folder names campo cannot be empty."
        
        return ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: onDone) {
                Text("Done")
            }
            .alert(title, isPresented: $isShowAlert,
                   actions: {
                        Button("OK") {
                            isShowAlert = false
                        }
                    },
                   message: {
                       Text(message)
                    }
            )
        }
    }
    
    private var cancelToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel", action: onCancel)
        }
    }
    
    private var canDone: Bool {
        let trimedName = name.trimmingCharacters(in: .whitespaces)
        return trimedName.count > 0
    }
}

#Preview {
    NewFolderView()
}
