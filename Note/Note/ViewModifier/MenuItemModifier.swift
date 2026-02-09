//
//  MenuItemModifier.swift
//  Note
//
//  Created by nyaago on 2026/01/28.
//

import SwiftUI

struct MenuItemModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.leading, 32)
            .background(Color.blue)
            .cornerRadius(10)
    }
}
