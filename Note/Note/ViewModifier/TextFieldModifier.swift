//
//  TextFieldModifier.swift
//  Note
//
//  Created by nyaago on 2026/01/11.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .frame(width: .infinity, height: .infinity)
    }
}
