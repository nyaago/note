//
//  ListItemContentModifier.swift
//  Note
//
//  Created by nyaago on 2026/01/03.
//

import SwiftUI

struct ListItemContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .lineLimit(1, reservesSpace: true)
            .frame(alignment: .leading)
    }
}
