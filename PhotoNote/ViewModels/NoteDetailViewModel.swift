//
//  NoteDetailViewModel.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import Foundation
import MapKit
import SwiftUI

@Observable
class NoteDetailViewModel {
    let note: NoteModel
    let locationFetcher = LocationFetcher()
    
    var noteCLLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: note.latitude, longitude: note.longitude)
    }
    
    var locationString = "Unknown location"
    
    var defaultCLLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var cameraPos: MapCameraPosition = .region(MKCoordinateRegion(center: MapDetails.defaultRegion, span: MapDetails.defaultSpan))
    
    func getPosition() {
        defaultCLLocation = CLLocationCoordinate2D(latitude: note.latitude, longitude: note.longitude)
        print(note.longitude)
        print(note.latitude)
        cameraPos = .region(MKCoordinateRegion(center: defaultCLLocation, span: MapDetails.defaultSpan))
    }
    
    init(note: NoteModel) {
        self.note = note
    }
}
