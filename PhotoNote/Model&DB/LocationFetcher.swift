//
//  LocationFetcher.swift
//  PhotoNote
//
//  Created by Maks Winters on 27.01.2024.
//
// https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        setupLocationManager()
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            lastKnownLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func lookUpCurrentLocation(rawLocation: CLLocationCoordinate2D, completionHandler: @escaping (String) -> Void) {
        let lastLocation = CLLocation(latitude: rawLocation.latitude, longitude: rawLocation.longitude)
            let geocoder = CLGeocoder()
                
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                    let country = placemarks?[0].country
                    let city = placemarks?[0].locality
                    completionHandler("\(city ?? "area"), \(country ?? "Unknown")")
            })
    }
    
}
