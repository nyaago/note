//
//  SwiftUIView.swift
//  Note
//
//  Created by nyaago on 2026/01/03.
//

import SwiftUI

struct TextEditorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .frame(width: .infinity, height: .infinity)
    }
}
