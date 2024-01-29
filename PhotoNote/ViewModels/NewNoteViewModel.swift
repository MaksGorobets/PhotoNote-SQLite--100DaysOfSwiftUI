//
//  NewNoteViewModel.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//
// https://swiftwithmajid.com/2023/04/25/photospicker-in-swiftui/
//

import Foundation
import SwiftUI
import PhotosUI
import MapKit

enum MapDetails {
    static let defaultRegion = CLLocationCoordinate2D(latitude: 8.7832, longitude: 124.5085)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

@Observable
class NewNoteViewModel {
    private let dbManager = DBManager()
    let locationFetcher = LocationFetcher()
    
    var rawLocation = MapDetails.defaultRegion
    var currentPos = MapCameraPosition.region(MKCoordinateRegion(center: MapDetails.defaultRegion, span: MapDetails.defaultSpan))
    var locationString = "Unknown location"

    
    var photoData: Data?
    var photoImage: Image?
    
    var saved: () -> Void
    
    var pickerItem: PhotosPickerItem? { didSet {
        Task {
            await convertPickerItem()
        }
    }}
    var title: String = ""
    
    func setLocation() {
        if let location = locationFetcher.lastKnownLocation {
            rawLocation = location
            print(location)
            currentPos = .region(MKCoordinateRegion(center: location, span: MapDetails.defaultSpan))
        } else {
            print("Your location is unknown")
        }
    }
    
    func addNote() {
        print("Starting to add a note")
        guard let unwData = photoData else { return }
        print("Photo data - OK")
        guard !title.isEmpty else { return }
        print("Title - OK")
        
        dbManager.addNote(photoData: unwData, titleValue: title, longitudeValue: rawLocation.longitude, latitudeValue: rawLocation.latitude)
        print("Calling the addNote function")
        saved()
    }
    
    private func convertPickerItem() async {
        guard (pickerItem != nil) else { return }
        do {
            let initialData = try await pickerItem?.loadTransferable(type: Data.self)
            photoData = UIImage(data: initialData!)?.jpeg(.lowest)
            let uiImage = UIImage(data: photoData!)
            photoImage = Image(uiImage: uiImage ?? UIImage())
        } catch {
            print(error.localizedDescription)
        }
    }

    
    
    init(saved: @escaping () -> Void) {
        self.saved = saved
    }
}
