//
//  EditFolderSheetView.swift
//  Note
//
//  Created by nyaago on 2026/02/09.
//

import SwiftUI
import SwiftData

struct RenameFolderSheetView: View {
    let folder: Folder
    @State var name: String = ""
    @Environment(\.dismiss) private var dismiss
    
    init(folder: Folder) {
        self.folder = folder
        self.name = folder.name
    }
    
    var body: some View {
        VStack {
            HStack() {
                VStack(alignment: .center) {
                    Text("Rename Folder")
                }
            }
            Form {
                TextField("name", text: $name)
                    .onAppear() {
                        self.name = folder.name
                    }
            }
            HStack {
                Spacer()
                ActionButton(action: {
                    dismiss()
                }, text: "Cancel")
                Spacer()
                ActionButton(action: {
                    renameFolderAndDismiss()
                }, text: "OK")
                Spacer()
            }.padding(20)
        }.onAppear() {
        }
    }
    
    private func renameFolder() {
        self.folder.name = self.name
    }
    
    private func renameFolderAndDismiss() {
        renameFolder()
        dismiss()
    }

}

#Preview {
    RenameFolderSheetView(folder: Folder(name: "Folder"))
}
