//
//  SectionHeaderModifier.swift
//  Note
//
//  Created by nyaago on 2026/01/23.
//

import SwiftUI

struct SectionHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(width: .infinity, height: .infinity)
    }
}
