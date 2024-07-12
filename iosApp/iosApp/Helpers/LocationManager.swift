//
//  LocationManager.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared = LocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .notDetermined:
            print("DEBUG: not determined")
            break
        case .restricted:
            print("DEBUG: restricted")
            break
        case .denied:
            print("DEBUG: denied")
            break
        case .authorizedAlways:
            print("DEBUG: auth always")
            break
        case .authorizedWhenInUse:
            print("DEBUG: auth when in use")
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
}
