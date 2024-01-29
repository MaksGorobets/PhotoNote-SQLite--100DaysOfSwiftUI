//
//  ContentView.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//
// https://www.hackingwithswift.com/books/ios-swiftui/deleting-items-using-ondelete
//

import SwiftUI

struct ContentView: View {
    
    @Bindable var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.notesModels.isEmpty {
                    List {
                        ForEach(viewModel.notesModels) { note in
                            NavigationLink(value: note) {
                                HStack {
                                    note.swiftUIImage
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .padding(.vertical, 5)
                                    Text(note.title)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            viewModel.removeRows(at: indexSet)
                        })
                    }
                } else {
                    ContentUnavailableView("No data", systemImage: "tray.2.fill")
                }
            }
            .navigationDestination(for: NoteModel.self) { note in
                NoteDetailView(note: note)
            }
            .onAppear(perform: viewModel.loadNotes)
            .toolbar {
                Button("Add") {
                    viewModel.isShowingSheet.toggle()
                }
            }
            .sheet(isPresented: $viewModel.isShowingSheet, content: {
                NewNoteView(saved: {
                    viewModel.loadNotes()
                })
                    .presentationDetents([.large])
                    .presentationBackground(.ultraThinMaterial)
            })
            .navigationTitle("PhotoNote")
        }
    }
}

#Preview {
    ContentView()
}
