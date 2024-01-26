//
//  NoteDetailView.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import SwiftUI

struct NoteDetailView: View {
    
    let viewModel: NoteDetailViewModel
    
    var body: some View {
        viewModel.note.swiftUIImage
            .resizable()
            .scaledToFit()
        Text(viewModel.note.title)
            .font(.title)
        Spacer()
    }
    
    init(note: NoteModel) {
        self.viewModel = NoteDetailViewModel(note: note)
    }
}

#Preview {
    NoteDetailView(note: NoteModel())
}
