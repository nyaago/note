//
//  ActionButton.swift
//  Note
//
//  Created by nyaago on 2026/02/11.
//

import SwiftUI

struct ActionButton: View {
    let action: () -> Void
    let text: String
    
    init(action: @escaping () -> Void, text: String) {
        self.action = action
        self.text = text
    }
    
    var body: some View {
        Button(action: {
            self.action()
            }) {
                Text(text)
                    .font(.body)
                    .frame(width: 100, height: 30, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
            }
            .foregroundColor(.gray)
    }
}

#Preview {
    ActionButton(action: {
        print("Hello!")
    }, text: "Hello")
}
