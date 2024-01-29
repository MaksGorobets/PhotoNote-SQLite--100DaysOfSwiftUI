//
//  NoteDetailView.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import SwiftUI
import MapKit

struct NoteDetailView: View {
    
    @Bindable var viewModel: NoteDetailViewModel
    
    var body: some View {
            ScrollView {
                viewModel.note.swiftUIImage
                    .resizable()
                    .scaledToFit()
                Text(viewModel.note.title)
                    .font(.title)
                Map(position: $viewModel.cameraPos) {
                    Marker(viewModel.note.title, coordinate: viewModel.defaultCLLocation)
                }
                .frame(height: 250)
                .allowsHitTesting(false)
                .onAppear(perform: viewModel.getPosition)
                Text(viewModel.locationString)
                    .onAppear {
                        viewModel.locationFetcher.lookUpCurrentLocation(rawLocation: viewModel.noteCLLocation) { placeStr in
                            viewModel.locationString = placeStr
                        }
                    }
            }
            .navigationTitle(viewModel.note.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    
    init(note: NoteModel) {
        self.viewModel = NoteDetailViewModel(note: note)
    }
}

#Preview {
    NoteDetailView(note: NoteModel())
}
