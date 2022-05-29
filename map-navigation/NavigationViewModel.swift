//
//  NavigationViewModel.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/29.
//

import Foundation
import CoreLocation

// view model layer

class NavigationViewModel: NSObject, ObservableObject {
    @Published private var model: Navigation

    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    var updateLocationCompletionHandler: ((CLLocationCoordinate2D?) -> Void)?
    
    
    init(with model: Navigation) {
        self.model = model
    }
    
    // MARK: - Intent(s)
    func requestUserLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        updateLocationCompletionHandler = completion
        locationManager.startUpdatingLocation()
    }
    
    func setDestination(_ coordinate: CLLocationCoordinate2D) {
        model.destination = coordinate
    }
}

extension NavigationViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(
            latitude: userLocation!.coordinate.latitude,
            longitude: userLocation!.coordinate.longitude
        )

        updateLocationCompletionHandler?(center)
        model.currentLocation = center
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationCompletionHandler?(nil)
        locationManager.stopUpdatingLocation()
    }
    
}
