//
//  Navigation.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/29.
//

import Foundation
import GoogleMapsDirections
import GoogleMaps
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
    var routePath: GMSPath? {
        if let route = routes?.first, let points = route.overviewPolylinePoints as String? {
            if let path = GMSPath.init(fromEncodedPath: points) {
                return path
            }
        }
        return nil
    }
    
    var userPathPoints = [LocationCoordinate2D]()
    
    var userPath: GMSPath? {
        if userPathPoints.count > 1 {
            let path = GMSMutablePath()
            for coord in userPathPoints {
                path.addLatitude(coord.latitude, longitude: coord.longitude)
            }
            return path
        } else {
            return nil
        }
    }
    
}

extension GoogleMapsDirections.LocationCoordinate2D: Equatable {
    public static func == (lhs: GoogleMapsService.LocationCoordinate2D, rhs: GoogleMapsService.LocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
