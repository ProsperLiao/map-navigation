//
//  MapView.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/28.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // do nothing here
    }
    
}
