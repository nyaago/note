//
//  ContentView.swift
//  Note
//
//  Created by nyaago on 2025/12/04.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var path = NavigationPath()
    @Environment(\.modelContext) private var modelContext
    @StateObject private var navigationRouter = NavigationRouter()
    @Query private var notes: [Note]

    var body: some View {
        NavigationStack(path: $navigationRouter.path) {
            FolderListView()
        }
        .environment(\.navigationRouter, navigationRouter)
    }
}

private extension ContentView {
    
}

#Preview {
    ContentView()
        .modelContainer(SampleFolder.previewContainer)
}
