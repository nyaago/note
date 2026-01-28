//
//  MenuItemLabel.swift
//  Note
//
//  Created by nyaago on 2026/01/28.
//

import SwiftUI

struct MenuItemLabel: View {
    let systemImage: String
    let text: String
    
    init(systemImage: String = "", text: String = "") {
        self.systemImage = systemImage
        self.text = text
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(text)
        }.modifier(MenuItemModifier())
    }
}

#Preview {
    MenuItemLabel(systemImage: "folder", text: "Move")
}
