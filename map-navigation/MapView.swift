//
//  MapView.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/28.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var viewModel: NavigationViewModel
    
    func makeUIView(context: Context) -> GMSMapView {
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate 41.89320605034929, -87.62215910952642 at zoom level 13.
        let camera = GMSCameraPosition.camera(withLatitude: 41.89320605034929, longitude: -87.62215910952642, zoom: 13)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true

        mapView.delegate = context.coordinator
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.requestUserLocation { userLocation in
                if let userLocation = userLocation {
                    let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 15.0)
                    mapView.camera = camera
                }
            }
        }
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // do nothing here
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: viewModel)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        let viewModel: NavigationViewModel
        
        init(with viewModel: NavigationViewModel) {
            self.viewModel = viewModel
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            mapView.clear()
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude  , longitude: coordinate.longitude)
            marker.map = mapView
            
            viewModel.setDestination(coordinate)
        }
        
    }
    
}
