//
//  ListItemViewModifier.swift
//  Note
//
//  Created by nyaago on 2026/01/13.
//

import SwiftUI

struct ListItemViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .frame(minHeight: 30)
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                    .zero
            }
    }
}
