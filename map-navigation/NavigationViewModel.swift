//
//  NavigationViewModel.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/29.
//

import Foundation
import CoreLocation
import GoogleMapsDirections
import Keys


// view model layer

class NavigationViewModel: NSObject, ObservableObject {
    @Published private var model: Navigation
    
    var timer: Timer?
    
    var routes: [GoogleMapsDirections.Response.Route]? {
        model.routes
    }
    
    var destination: CLLocationCoordinate2D? {
        get {
            if let dest = model.destination {
                return CLLocationCoordinate2D(latitude: dest.latitude, longitude: dest.longitude)
            } else {
                return nil
            }
        }
        set {
            if let dest = newValue {
                model.destination = GoogleMapsDirections.LocationCoordinate2D(latitude: dest.latitude, longitude: dest.longitude)
            } else {
                model.destination = nil
            }
        }
    }
    
    var isNavigating: Bool {
        model.isNavigating
    }
    
    var clearMapView = false
    
    var userLocationUpdateHandler: ((CLLocationCoordinate2D) -> Void)?

    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    init(with model: Navigation) {
        self.model = model
        let keys = MapNavigationKeys()
        GoogleMapsDirections.provide(apiKey: keys.googleMapsAPIKey)

    }
    
    // MARK: - Intent(s)
    func requestUserLocation(completion: @escaping (CLLocationCoordinate2D) -> Void) {
        userLocationUpdateHandler = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func cancelNavigation() {
        guard model.isNavigating else { return }
        guard let current = model.currentLocation, let _ = model.destination else { return }
        model.isNavigating = false
        model.destination = nil
        model.routes = nil
        clearMapView = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {[weak self] in
            self?.clearMapView = false
        }
        model.origin = current
        timer?.invalidate()
    }
    
    func startNavigation(by travelMode: GoogleMapsDirections.TravelMode = .walking) {
        guard !model.isNavigating else { return }
        guard let current = model.currentLocation, let _ = model.destination else { return }
        model.isNavigating = true
        model.origin = current
        model.travelMode = travelMode
        requestDirections()
        
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            self?.locationManager.startUpdatingLocation()
        }
        
    }
    
    func requestDirections() {
        if let current = model.currentLocation, let dest = model.destination {
            GoogleMapsDirections.direction(
                fromOriginCoordinate: current,
                toDestinationCoordinate: dest,
                travelMode: model.travelMode
            ) { [weak self] (response, error) -> Void in
                // Check Status Code
                guard response?.status == GoogleMapsDirections.StatusCode.ok else {
                    // Status Code is Not OK
                    debugPrint(response?.errorMessage as Any)
//                    self?.model.isNavigating = false
                    return
                }
                
                // Use .result or .geocodedWaypoints to access response details
                // response will have same structure as what Google Maps Directions API returns
                debugPrint("it has \(response?.routes.count ?? 0) routes")
                
                self?.model.routes = response?.routes
//                self?.model.isNavigating = false
            }
        }
    }
}
    

extension NavigationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        model.currentLocation = GoogleMapsDirections.LocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        requestDirections()
        userLocationUpdateHandler?(CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude))
        userLocationUpdateHandler = nil
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
//        locationManager.stopUpdatingLocation()
    }
    
}
