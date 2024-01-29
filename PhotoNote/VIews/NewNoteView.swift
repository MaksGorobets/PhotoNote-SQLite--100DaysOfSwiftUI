//
//  NewNoteView.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import SwiftUI
import PhotosUI
import MapKit

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
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 30.0))
                    .padding()
            }
            HStack {
                TextField("Enter note title", text: $viewModel.title)
                PhotosPicker("Pick a photo", selection: $viewModel.pickerItem, matching: .images)
                    .buttonStyle(.bordered)
            }
            .padding()
            
                .toolbar {
                    Button("Done") {
                        viewModel.addNote()
                        dismiss()
                    }
                }
            Map(position: $viewModel.currentPos) {
                Marker("Place", coordinate: viewModel.rawLocation)
            }
                .frame(height: 250)
                .allowsHitTesting(false)
            Text(viewModel.locationString)
                .onAppear {
                    viewModel.locationFetcher.lookUpCurrentLocation(rawLocation: viewModel.rawLocation)
                    { placeStr in
                            viewModel.locationString = placeStr
                    }
                }
            Spacer()
                .onAppear {
                    viewModel.setLocation()
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
