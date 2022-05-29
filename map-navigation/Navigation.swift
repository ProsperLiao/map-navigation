//
//  Navigation.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/29.
//

import Foundation
import CoreLocation

// model layer

struct Navigation {
    var origin: CLLocationCoordinate2D?
    var destination: CLLocationCoordinate2D?
    var currentLocation: CLLocationCoordinate2D?
}
