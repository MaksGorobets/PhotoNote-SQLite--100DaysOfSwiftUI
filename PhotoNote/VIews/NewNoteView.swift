//
//  NewNoteView.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import SwiftUI
import PhotosUI

struct NewNoteView: View {
    
    @Bindable var viewModel: NewNoteViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            if viewModel.photoImage != nil {
                viewModel.photoImage!
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .padding()
            }
            TextField("Enter note title", text: $viewModel.title)
                .padding()
            PhotosPicker("Pick a photo", selection: $viewModel.pickerItem, matching: .images)
                .buttonStyle(.bordered)
            
                .toolbar {
                    Button("Done") {
                        viewModel.addNote()
                        dismiss()
                    }
                }
            .navigationTitle("Add a note")
        }
    }
    
    init(saved: @escaping () -> Void) {
        self.viewModel = NewNoteViewModel(saved: saved)
    }
    
}

#Preview {
    NewNoteView(saved: {})
}
