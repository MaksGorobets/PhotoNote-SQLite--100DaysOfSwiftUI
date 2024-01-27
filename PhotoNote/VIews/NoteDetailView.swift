//
//  NoteDetailView.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import SwiftUI
import MapKit

struct NoteDetailView: View {
    
    let viewModel: NoteDetailViewModel
    
    var body: some View {
        viewModel.note.swiftUIImage
            .resizable()
            .scaledToFit()
        Text(viewModel.note.title)
            .font(.title)
        Map(initialPosition: MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.note.latitude, longitude: viewModel.note.longitude), span: MapDetails.defaultSpan)))
            .frame(height: 300)
        Spacer()
    }
    
    init(note: NoteModel) {
        self.viewModel = NoteDetailViewModel(note: note)
    }
}

#Preview {
    NoteDetailView(note: NoteModel())
}
