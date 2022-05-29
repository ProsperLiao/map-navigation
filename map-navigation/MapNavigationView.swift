//
//  MapNavigationView.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/27.
//

import SwiftUI

struct MapNavigationView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let navigationViewModel = NavigationViewModel(with: Navigation())
        MapNavigationView()
            .environmentObject(navigationViewModel)
    }
}
