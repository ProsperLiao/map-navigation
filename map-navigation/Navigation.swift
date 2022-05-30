//
//  Navigation.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/29.
//

import Foundation
import GoogleMapsDirections
import Keys

// model layer
struct Navigation {
    typealias LocationCoordinate2D = GoogleMapsDirections.LocationCoordinate2D
    typealias TravelMode = GoogleMapsDirections.TravelMode
    
    var currentLocation: LocationCoordinate2D? {
        didSet {
            if let current = currentLocation, isNavigating && current != oldValue{
                userPathPoints.append(current)
            }
        }
    }
    
    var origin: LocationCoordinate2D?
    var destination: LocationCoordinate2D?
    var travelMode: TravelMode = .walking
    var isNavigating: Bool = false
    
    var routes: [GoogleMapsDirections.Response.Route]?
    
    var userPathPoints = [LocationCoordinate2D]()
}

extension GoogleMapsDirections.LocationCoordinate2D: Equatable {
    public static func == (lhs: GoogleMapsService.LocationCoordinate2D, rhs: GoogleMapsService.LocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
