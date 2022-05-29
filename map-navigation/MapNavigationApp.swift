//
//  MapNavigationApp.swift
//  MapNavigation
//
//  Created by Hongxing Liao on 2022/5/27.
//

import SwiftUI

@main
struct MapNavigationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let navigationViewModel = NavigationViewModel(with: Navigation())
    
    var body: some Scene {
        WindowGroup {
            MapNavigationView()
                .environmentObject(navigationViewModel)
        }
    }
}
