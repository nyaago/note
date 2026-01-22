//
//  NoteListView.swift
//  Note
//
//  Created by nyaago on 2025/12/08.
//

import SwiftUI
import SwiftData

struct NoteItemView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.content)
                .modifier(ListItemContentModifier())
            Text(note.formatedTimestamp)
                .modifier(ListItemNoteModifier())
        }
        .modifier(ListItemViewModifier())
    }
}

struct NoteSection: Identifiable {
    let id = UUID()
    let date: Date
    let notes: [Note]
    
    init(date: Date, notes: [Note]) {
        self.date = date
        self.notes = notes
    }
}

struct NoteSectionView: View {
    let date: Date
    var body: some View {
        Text(formatedDate)
    }
    
    private var formatedDate: String {
        let now = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: date, to: now).day!
        if elapsedDays > 30 {
            return DateFormatUtil.formatDate(date: date)
        }
        else {
            return DateFormatUtil.formatRelativeDate(date: date)
        }
    }
}


struct NoteListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.navigationRouter) private var navigationRouter
    
    @State private var creatingFolder = false
    
    @Query private var notes: [Note]
    
    private var folder: Folder?
    
    init() {
        self.init(folder: nil)
    }
    
    init(folder: Folder?) {
        self.folder = folder
        let sortDescriptions = Note.defaultSortDescriptors()
        let predicate = Note.predicateForfilteingByFolder(folder: folder)
        _notes = Query(filter: predicate, sort: sortDescriptions)
    }
    
    var body: some View {
        List {
            ForEach(groupingNotes)  { group in
                Section(header: NoteSectionView(date: group.date)) {
                    ForEach(group.notes) { note in
                        NavigationLink(value :note, label: {
                            NoteItemView(note: note)
                        })
                    }
                }
            }
            .onDelete(perform: deleteNotes)
        }
        .toolbar {
            editToolbarContent
            addToolbarContent
        }
        .navigationTitle(navigationTitle)
        .navigationDestination(for: Note.self, destination:  { note in
            EditNoteItemView(note: note)
        })
        .navigationDestination(isPresented: $creatingFolder, destination: {
            NewFolderView()
        })

    }
    private func addNote() {
        withAnimation {
            let newItem = Note(content: "", folder: folder)
            modelContext.insert(newItem)
            navigationRouter.path.append(newItem)
        }
    }
    
    
    private func addFolder() {
        withAnimation {
            creatingFolder = true
        }
    }
    
    private func doNothing() {
        
    }
    
    private func isTodayNote(note: Note) -> Bool {
        let now = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: note.timestamp, to: now).day!
        if elapsedDays == 0 {
            return true
        }
        return false
    }

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
    
    private var navigationTitle: String {
        if let folder = self.folder {
            return folder.name
        }
        else {
            return "全て"
        }
    }
    
    private var editToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
        }
    }
    
    private var addToolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            HStack()  {
                Button(action: doNothing) {
                 }
                Button(action: addNote) {
                    Label("Add Item", systemImage: "square.and.pencil")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    private var groupingNotes: Array<NoteSection> {
        let array: Array<(key: Date, value: Array<Note>)> = Note.groupingNotes(notes: notes)
        let newArray = array.map( { pair in
            NoteSection(date: pair.key, notes: pair.value)
        } )
        return newArray
    }
}

#Preview {
    NoteListView()
        .modelContainer(SampleNote.previewContainer)}
