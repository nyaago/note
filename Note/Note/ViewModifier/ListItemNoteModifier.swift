//
//  ListItemNoteModifier.swift
//  Note
//
//  Created by nyaago on 2026/01/03.
//

import SwiftUI

struct ListItemNoteModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .lineLimit(1, reservesSpace: true)
            .frame(alignment: .leading)
    }
}
