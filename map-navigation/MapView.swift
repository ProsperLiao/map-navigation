//
//  MapView.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/28.
//

import SwiftUI
import GoogleMaps
import Combine
import GoogleMapsDirections

struct MapView: UIViewRepresentable {
    var viewModel: NavigationViewModel

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
        
        viewModel.requestUserLocation { location in
            let camera = GMSCameraPosition.camera(withTarget: location, zoom: 15.0)
            mapView.camera = camera
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        debugPrint("update UI View")
        debugPrint(viewModel.routes as Any)
        
        context.coordinator.setPath(routePath: viewModel.routePath, userPath: viewModel.userPath, map: uiView)
        
        if viewModel.isFinished {
            context.coordinator.finish(routePath: viewModel.routePath, userPath: viewModel.userPath, map: uiView)
        }
        if viewModel.clearMapView {
            uiView.clear()
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: viewModel)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        let viewModel: NavigationViewModel
        
        var routeLine: GMSPolyline?
        var userLine: GMSPolyline?
        
        init(with viewModel: NavigationViewModel) {
            self.viewModel = viewModel
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            guard !viewModel.isNavigating else { return }
            mapView.clear()
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            marker.map = mapView
            
            viewModel.destination = coordinate
        }
        
        func setPath(routePath: GMSPath?, userPath: GMSPath?, map: GMSMapView) {
            routeLine?.map = nil
            userLine?.map = nil
            if let routePath = routePath {
                routeLine = GMSPolyline.init(path: routePath)
                routeLine?.strokeColor = .green
                routeLine?.strokeWidth = 8
                routeLine?.map = map
            }
            if let userPath = userPath {
                userLine = GMSPolyline.init(path: userPath)
                userLine?.strokeColor = .red
                userLine?.strokeWidth = 3
                userLine?.map = map
            }
        }
        
        func finish(routePath: GMSPath?, userPath: GMSPath?, map: GMSMapView) {
//            routeLine?.map = nil
            userLine?.map = nil
//            if let routePath = routePath {
//                routeLine = GMSPolyline.init(path: routePath)
//                routeLine?.strokeColor = UIColor.blue
//                routeLine?.strokeWidth = 5
//                routeLine?.map = map
//            }
//            if let userPath = userPath {
//                userLine = GMSPolyline.init(path: userPath)
//                userLine?.strokeColor = .red
//                userLine?.strokeWidth = 5
//                userLine?.map = map
//            }
            
            if let path = userLine?.path {
                var bounds = GMSCoordinateBounds()
                for index in 1...path.count() {
                    bounds = bounds.includingCoordinate(userLine!.path!.coordinate(at: index))
                }
                
                map.moveCamera(GMSCameraUpdate.fit(bounds))
            }
        }

            //optional - get distance of the route in kms!
    //        let mtrs = GMSGeometryLength(path)
    //        dist = mtrs/1000.0
    //        print("The distance of the route is \(dist) km")
            
    }
    
}
