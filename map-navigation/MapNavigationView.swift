//
//  MapNavigationView.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/27.
//

import SwiftUI
import GoogleMapsDirections

struct MapNavigationView: View {
    @EnvironmentObject var viewModel: NavigationViewModel
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel)
                .ignoresSafeArea()
            
            VStack {
                if viewModel.isFinished {
                    VStack {
                        Text("Elapsed Time: \(viewModel.elapsedTime ?? 0) seconds")
                        Text("Total distance traveled: \(viewModel.travelDistance)")
                    }.foregroundColor(.red)
                }
                Spacer()
                
                HStack {
                    Button("Start Navigation") {
                        viewModel.startNavigation()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .controlSize(.regular)
                    .disabled(viewModel.isNavigating || viewModel.destination == nil)
                    Button("Cancel") {
                        viewModel.cancelNavigation()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .controlSize(.regular)
                    .disabled(!viewModel.isNavigating)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NavigationViewModel(with: Navigation())
        MapNavigationView()
            .environmentObject(viewModel)
    }
}
